Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWFSAwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWFSAwl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 20:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWFSAwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 20:52:41 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:36508 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750825AbWFSAwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 20:52:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Nc5h6Mm5TfQ+G2mTeEh7JLOPomvN7+d4YDB1dWcuiJvSkOR2TAo8XJmEphKmMG7qDPyPUzAYK3IUuG7WTrnrSpUHJlBbibtv9CaWqHdq5po/GByfxnnByGJX2nV1eO/iaql7KPKq0JSZiL7RAEzqHKgsSOIl23jr+hsyZxU+f9M=
Message-ID: <787b0d920606181752j4b7c7309t9c0ab9bf8da1537a@mail.gmail.com>
Date: Sun, 18 Jun 2006 20:52:40 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [ckpatch][15/29] hz-no_default_250.patch
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Make 250 HZ a value that is not selected by default and give some
> better recommendations in help.

No, 250 is a good default.

We can't reliably do 1000. There are many systems, including both
laptops and servers, which have a BIOS that uses SMM/SMI to grab
the CPU for longer than a millisecond. We'd lose clock ticks if
we had HZ at 1000.

NTSC video is 59.94 fields per second. Though a sample rate of
double that would satisfy the Nyquest theory, in practice you
need to go to 4x to 5x the rate you want. This comes out to be
around 240 to 300 as a minimum.

Then there is the matter of picking a value that is very close
to being an integer factor of the standard PC clock. I don't
remember how well 250 did, but here is the code I once used
to compute such things:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <float.h>
#include <math.h>

// 1189200.0 // AMD ELAN
// 1193182.0 // normal

#define PITHZ 1193182.0

double nearbyint(double x);

#define TARGET_MAX 1300 // was 15000
#define TARGET_MIN 240  // was 9

int main(int argc, char *argv[]){
  unsigned target = TARGET_MAX;
  while(--target>TARGET_MIN){
st:;
    unsigned setting = nearbyint(PITHZ / target);
    double actual = PITHZ / setting;
    double diff = actual - target;
    double perc = 100.0*diff/target;
//    if(target & 3) continue;
#if 1
    if(target!=1000 && target !=1024 && target!=100 && target!=400 &&
target!=600
      && target!=1200 && target!=240 && target!=300 && target!=800
      && target!=512 && target!=256 && target!=128)
      if(perc > 0.01 || perc < -0.01) continue;
#else
    {
    if(perc>-0.6 && perc<0.6) continue;
    }
#endif
    printf("%+11.8f %+10.6f %6u %5u %12.6f\n", perc, diff, setting,
target, actual);
  }
  if(target>105) {
    target = 100;
    goto st;
  }
  return 0;
}
