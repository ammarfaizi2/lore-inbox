Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993106AbWJUP11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993106AbWJUP11 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 11:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993107AbWJUP11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 11:27:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16794 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S2993106AbWJUP10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 11:27:26 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] handle ext3 directory corruption better
Date: Sat, 21 Oct 2006 11:29:23 -0400
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610211129.23216.sgrubb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've been using Steve Grubb's purely evil "fsfuzzer" tool, at
>http://people.redhat.com/sgrubb/files/fsfuzzer-0.4.tar.gz

Oops, I didn't know this was going to be mentioned and deleted the file. The 
current release is 0.5 and I've symlinked it to the address Eric mentioned 
above. That said, I would like to say a couple things about the program. 

Bugs found by fuzzing falls into 2 categories, robustness and security. Its 
very possible to overflow stacks or find signed/unsigned conversion problems 
which can be exploited by malicious users. It is also expected by people that 
the OS tolerate errors. If you have defective media, you may need to access 
the drive in attempt to salvage what you can. Or maybe someone walks by with 
specially doctored USB stick and jams it in your desktop computer while you 
are away. The automounter then mounts and reads the initial directory...boom.

To help find these kind of problems, I worked on a program, fsfuzz, that can 
create all sorts of errors. The initial idea for the program comes from LMH. 
The tool saves the image that crashed your machine so that you can replay the 
problem and study it. This program has killed all the file systems it 
currently supports in the latest rawhide kernel - except swap. Virtually 
every file system in the current kernel can be used to oops or lockup a 
machine. Currently supported filesystems include:

ext2/3
swap
iso9660
vfat/msdos
cramfs
squashfs
xfs
hfs
gfs2

The way that the program works falls into this general pattern, it creates an 
initial file system image, corrupts it, then loopback mounts it, and tries 
various operations. If that passes, it corrupts the image in a different way 
and repeats.

The initial image is created in one of 2 ways, either dd a file or mkdir a 
directory depending on what the filesystem creation tools call for. To 
corrupt the image, a version of mangle is used. Mangle is a program that 
corrupts about 10% of the data and favors bytes with a value > 128 to induce 
signed/unsigned problems. The corrupted image is exercised by a program 
called run_test. I separated it from the main program so that you can replay 
a test and debug what is happening.

So, to wrap up...anyone that has anything to do with file system development 
may want to give this tool a try to see how robust any given file system is. 
The program can be grabbed here:

http://people.redhat.com/sgrubb/files/fsfuzzer-0.5.tar.gz

There is a README  file that explains more about using it. I am taking patches 
if you have any ideas about supporting file systems not already covered or 
ideas for new tests to exercise different filesystem operations.

-Steve
