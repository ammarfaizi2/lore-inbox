Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290719AbSA3W5A>; Wed, 30 Jan 2002 17:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290722AbSA3W4k>; Wed, 30 Jan 2002 17:56:40 -0500
Received: from w147.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.147]:30337 "EHLO
	funky.gghcwest.COM") by vger.kernel.org with ESMTP
	id <S290719AbSA3W4e>; Wed, 30 Jan 2002 17:56:34 -0500
Subject: 2.4.17: pwrite destroys block I/O throughput
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 30 Jan 2002 14:55:00 -0800
Message-Id: <1012431302.17074.10.camel@heat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I've never heard of pwrite and pread before, but htdig apparently makes
very heavy use of it.  On my 2.4.17 SMP 2GB HIGHMEM + ext3 system,
running htdig destroys input rates for every other process.  htdig's
output proceeds at approximately 2MB/s, but input for the entire system
runs only at about 4KB/s (YES, KB!).  If I suspend htdig, system block
input increases to the normal rate of 10-50MB/s.  Output still works, as
a dd from /dev/zero to a 400MB file runs at about 25MB/s.

Is linux's pwrite() just horribly broken?  Is htdig the only program 
that uses it?

Here's a little snapshot of htdig's syscalls, strace -s 0:

pwrite(6, ""..., 8192, 20717568)        = 8192
pread(6, ""..., 8192, 138395648)        = 8192
pwrite(6, ""..., 8192, 127918080)       = 8192
pread(6, ""..., 8192, 179281920)        = 8192
pwrite(6, ""..., 8192, 79732736)        = 8192
pread(6, ""..., 8192, 137633792)        = 8192
pwrite(6, ""..., 8192, 28409856)        = 8192
pread(6, ""..., 8192, 157958144)        = 8192
pwrite(6, ""..., 8192, 96583680)        = 8192
pread(6, ""..., 8192, 141254656)        = 8192
pwrite(6, ""..., 8192, 131031040)       = 8192
pread(6, ""..., 8192, 19095552)         = 8192
pwrite(6, ""..., 8192, 82698240)        = 8192
pread(6, ""..., 8192, 170573824)        = 8192
pwrite(6, ""..., 8192, 152616960)       = 8192
pread(6, ""..., 8192, 207298560)        = 8192
pwrite(6, ""..., 8192, 148635648)       = 8192
pread(6, ""..., 8192, 202768384)        = 8192
pwrite(6, ""..., 8192, 174055424)       = 8192

It's seeking all over the place.  Maybe pwrite/pread bypass the elevator
and proper I/O scheduling.

-jwb

