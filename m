Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTJGP6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 11:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTJGP6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 11:58:45 -0400
Received: from gaia.cela.pl ([213.134.162.11]:23052 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261271AbTJGP6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 11:58:42 -0400
Date: Tue, 7 Oct 2003 17:56:30 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: Tigran Aivazian <tigran@veritas.com>,
       "Giacomo A. Catenazzi" <cate@debian.org>,
       <linux-kernel@vger.kernel.org>, <simon@urbanmyth.org>
Subject: RE: RFC: changes to microcode update driver.
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AFF5@scsmsx402.sc.intel.com>
Message-ID: <Pine.LNX.4.44.0310071747030.31485-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As Tigran pointed out, we are active in this area too. At this point we
> want to add support of the extended update format to the driver, before
> we ship the latest microcode data. Some of them require the new format.

Do we even have any use for a userspace utility anymore?
strace'ing the microcode_ctl -u process results in information that the 
microcode.dat file is converted to binary and written to 
/dev/cpu/microcode.  The following code:
#include <stdio.h>
int main (void) {
  int x[4], i;
  while ((i = scanf("%x, %x, %x, %x,\n", &x[0], &x[1], &x[2], &x[3])) > 0) 
fwrite(x, 4, i, stdout);
  return 0;
};
does the conversion to binary:
cat /etc/microcode.dat | grep -v "^/" | ./a.out > microcode.raw
and the following loads it:
dd bs=`ls -s --block-size=1 microcode.raw | cut -f 1 -d " "` 
if=microcode.raw of=/dev/cpu/microcode

Either distribute the microcode in binary form and load it via dd (in the 
/etc/rc.d/init.d/microcode script)
or include the text file parser in the microcode module - since the module 
is only needed during loading of the update this tiny amount of extra code 
is likely acceptable.  For reducing kernel size for embedded systems (any 
based on ia32 lacking the few kb?) try compiling the 2kb update relevant 
for the given processor directly into the kernel...

Just a few ideas...

MaZe.

