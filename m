Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266334AbUHFDnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUHFDnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 23:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266454AbUHFDnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 23:43:08 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:64408 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266334AbUHFDnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 23:43:02 -0400
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: linux-mm@vger.kernel.org, rl@hellgate.ch, wli@holomorphy.com
Content-Type: text/plain
Organization: 
Message-Id: <1091754711.1231.2388.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Aug 2004 21:11:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi writes:

> I really wanted /proc/pid/statm to die [1] and I still believe the
> reasoning is valid. As it doesn't look like that is going to happen,

It would be awful to lose statm, especially since WLI has fixes
for some of the problems. Just why do you want to kill statm?

Now quoting from your patch...

+ size     total program size (pages)  (same as VmSize in status)
+ resident size of memory portions (pages) (same as VmRSS in status)

There was a distinction here that has been lost. One of these
included memory-mapped hardware. You could see this with the
X server video memory.

For "top" running on a 2.2.xx or 2.4.xx kernel, the statm values
are better. Jim Warner determined this after careful examination,
and I have no desire to re-analyse the matter. Remember that user
tools are expected to run on both old and new kernels, while the
kernel is expected to support old apps. We call this an ABI...

+ shared   number of pages that are shared (i.e. backed by a file)

This isn't in the status file. It's shown in top's default output.
Since top must read this value from statm, it might as well use    
other parts of statm as well.                                    
                                       
+ trs      number of pages that are 'code' (not including libs; broken,
+       includes data segment)

Perhaps this works OK with the NX bit or on an Alpha? On a regular
i386 box, code and read-only data are pretty much the same.

Note: trs means "text RESIDENT set".

+ lrs      number of pages of library  (always 0 on 2.6)

This worked for a.out executables. (that 0x60000000 value is an
a.out constant) Oh well, trs will do.

+ drs      number of pages of data/stack  (including libs; broken,
+       includes library text)

Note: trs means "data RESIDENT set".

+ dt       number of dirty pages   (always 0 on 2.6)

This one would be useful.

These would be really useful too:
1. swap space used
2. swap space that would be used if fully paged out

For the pmap command, it would be nice to have per-mapping
values in the /proc/*/maps files. (resident, locked,
dirty, C-O-W, swapped...) 


