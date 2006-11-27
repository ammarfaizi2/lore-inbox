Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933065AbWK0TIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933065AbWK0TIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933186AbWK0TIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:08:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14276 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933065AbWK0TIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:08:50 -0500
Message-ID: <456B36EE.8000709@redhat.com>
Date: Mon, 27 Nov 2006 14:05:18 -0500
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eranian@hpl.hp.com
CC: perfmon@napali.hpl.hp.com, perfctr-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [perfmon] 2.6.19-rc6-git10 new perfmon code base + libpfm + pfmon
References: <20061127143705.GC24980@frankl.hpl.hp.com>
In-Reply-To: <20061127143705.GC24980@frankl.hpl.hp.com>
Content-Type: multipart/mixed;
 boundary="------------000407010508040203030606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000407010508040203030606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephane Eranian wrote:
> Hello,
> 
> I have released another version of the perfmon new code base package.
> This version of the kernel patch is relative to 2.6.19-rc6-git10.
> 
> This is a major update because it completes the changes requested 
> during the code review on LKML. As a consequence, the kernel interface
> is NOT backward compatible with previous v2.2 versions. This release has
> the v2.3 version number. Backward compatibility with v2.0 is maintained
> on Itanium processors.

Hi Stephane,

I have built the kernel with the new patches and tried things out on x86_64 an 
x88_64 machine with Fedora Core 4.  I attempted use the new libpfm and pfmon to 
update the source RPMs and  I noticed that there were some return values from 
read() and write() being ignored. When pfmon is being built as an RPM ignoring 
the read and write return values cause the rpmbuild to fail. Attached is a 
simple patch that stuffs the return values into dummy variable to avoid the 
warnings. This patch allows libpfm and pfmon the source RPMs to compile on FC4 
and Fedora Core rawhide.

-Will

--------------000407010508040203030606
Content-Type: text/x-patch;
 name="pfmon-fortify.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pfmon-fortify.patch"

--- pfmon-3.2-061127/pfmon/pfmon_util.c.fortify	2006-11-27 05:22:40.000000000 -0500
+++ pfmon-3.2-061127/pfmon/pfmon_util.c	2006-11-27 13:38:43.000000000 -0500
@@ -1031,6 +1031,7 @@
 	int fd;
 	size_t max, used;
 	char number[32];
+	ssize_t dummy;
 
 	if (options.opt_is22 == 0)
 		return (size_t)-1;
@@ -1042,7 +1043,7 @@
 	if (fd == -1)
 		return (size_t)-1;
 	memset(number, 0, sizeof(number));
-	read(fd, number, sizeof(number));
+	dummy = read(fd, number, sizeof(number));
 
 	close(fd);
 
@@ -1055,7 +1056,7 @@
 	if (fd == -1)
 		return (size_t)-1;
 	memset(number, 0, sizeof(number));
-	read(fd, number, sizeof(number));
+	dummy = read(fd, number, sizeof(number));
 	close(fd);
 
 	max = strtoul(number, NULL, 0);
--- pfmon-3.2-061127/pfmon/pfmon_task.c.fortify	2006-11-27 13:39:16.000000000 -0500
+++ pfmon-3.2-061127/pfmon/pfmon_task.c	2006-11-27 13:39:57.000000000 -0500
@@ -1675,6 +1675,7 @@
 	int ctrl_fd;
 	int max_fd;
 	int ndesc, msg_type;
+	ssize_t dummy;
 
 	/*
 	 * POSIX threads: 
@@ -1811,7 +1812,7 @@
 					/*
 					 * ack the removal
 					 */
-					write(workers[mycpu].from_worker[1], &msg, sizeof(msg));
+					dummy = write(workers[mycpu].from_worker[1], &msg, sizeof(msg));
 					break;
 
 				case PFMON_TASK_MSG_QUIT:

--------------000407010508040203030606--
