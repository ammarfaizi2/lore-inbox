Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUGCOIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUGCOIg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 10:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUGCOIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 10:08:36 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:15061 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265119AbUGCOIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 10:08:30 -0400
Date: Sat, 3 Jul 2004 16:08:29 +0200
From: bert hubert <ahu@ds9a.nl>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: small perfctr bug or misunderstanding
Message-ID: <20040703140829.GA13241@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
References: <200407031028.i63AS9W3018392@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407031028.i63AS9W3018392@harpo.it.uu.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 12:28:09PM +0200, Mikael Pettersson wrote:

> There would be a /proc/<pid>/<tid>/perfctr/ directory
> with files representing the control data, counter
> state, general info, and auxiliary control ops.

Mikael, thanks for the low-level-api.txt documentation. Will vperfctr_* see
some documentation? Want me to whip up manpages?

So far perfctr has been very useful to me already - I now know parts of
PowerDNS that are completely memory bound, which I so far only suspected.
Are the global counters available? There is a note in the perfctl
distribution that says they aren't?

One thing - on my Pentium M I'm unable to get more than one counter going
simultaneously, I get 'Operation not permitted'. Perfex reports that
supposedly two are possible.

PerfCtr Info:
abi_version		0x06000500
driver_version		2.7.3
cpu_type		14 (Intel Pentium M)
cpu_features		0x3 (rdpmc,rdtsc)
cpu_khz			1399252
tsc_to_cpu_mult		1
cpu_nrctrs		2
cpus			[0], total: 1
cpus_forbidden		[], total: 0

PERFCTR INIT: vendor 0, family 6, model 9, stepping 5, clock 1399252 kHz
PERFCTR INIT: NITER == 64
PERFCTR INIT: loop overhead is 118 cycles
PERFCTR INIT: rdtsc cost is 48.5 cycles (3223 total)
PERFCTR INIT: rdpmc cost is 45.4 cycles (3027 total)
PERFCTR INIT: rdmsr (counter) cost is 95.4 cycles (6229 total)
PERFCTR INIT: rdmsr (evntsel) cost is 81.3 cycles (5322 total)
PERFCTR INIT: wrmsr (counter) cost is 143.7 cycles (9318 total)
PERFCTR INIT: wrmsr (evntsel) cost is 132.3 cycles (8591 total)
PERFCTR INIT: read cr4 cost is 3.0 cycles (311 total)
PERFCTR INIT: write cr4 cost is 49.8 cycles (3308 total)
perfctr: driver 2.7.3, cpu type Intel P6 at 1399252 kHz

On my Athlon, 4 are reported possible and 4 work just fine. But I might be
misunderstanding the Intel docs.

The code below works fine when the second counter is commented out:

#include <iostream>
using namespace std;
extern "C" {
#include "libperfctr.h"
}
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "arch.h"

class PerfCtr
{
public:
  PerfCtr()
  {
    d_self = vperfctr_open();
    if( !d_self ) {
	perror("vperfctr_open");
	exit(1);
    }

    memset(&d_control.cpu_control, 0, sizeof(d_control.cpu_control));
    d_control.cpu_control.tsc_on=1;
  }

  void addCounter(unsigned int v, unsigned int unit=0) 
  {
    int count=d_control.cpu_control.nractrs;

    d_control.cpu_control.evntsel[count] = v | (1 << 16) | (1 << 22) | (unit << 8); 
    d_control.cpu_control.pmc_map[count] = count;
    d_control.cpu_control.nractrs++; // no support for .nrictrs
  }

  void go()
  {
    if(vperfctr_control(d_self, &d_control) < 0) {
      perror("vperfctr_control");
      exit(1);
    }
    zero();
  }

  void zero()
  {
    memset(&d_baseline,0,sizeof(d_baseline));
    vperfctr_read_ctrs(d_self, &d_baseline);
  }

  ~PerfCtr()
  {
    vperfctr_close(d_self);
  }

  void get(long long* counters, long long& tsc)
  {
    struct perfctr_sum_ctrs now;
    memset(&now,0,sizeof(d_baseline));
    if(vperfctr_read_ctrs(d_self, &now) < 0) {
      perror("read counters");
      exit(1);
    }
    
    for(unsigned int n=0;n<d_control.cpu_control.nractrs;++n)
      counters[n]=now.pmc[n] - d_baseline.pmc[n];

    tsc=now.tsc - d_baseline.tsc;
  }

private:
  struct vperfctr *d_self;
  struct vperfctr_control d_control;
  struct perfctr_sum_ctrs d_baseline;
};


int main()
{
  PerfCtr pc;
  pc.addCounter(0x48); // DCU MISS OUTSTANDING
  pc.addCounter(0x43); // DATA_MEM_REFS

  pc.go();

  long long results[2], tsc;
  pc.get(results,tsc);

  cout<<"Cycles waiting on DCU miss:  "<<results[0]<<endl;
  cout<<"Number of memory references: "<<results[1]<<endl;
  cout<<"Cycles spent:                "<<tsc<<endl;
}



-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
