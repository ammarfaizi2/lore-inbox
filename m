Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbTFEXBn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 19:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbTFEXBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 19:01:42 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:31015 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265253AbTFEXBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 19:01:41 -0400
Date: Thu, 5 Jun 2003 16:11:32 -0700
From: Andrew Morton <akpm@digeo.com>
To: Edward Tandi <ed@efix.biz>
Cc: linux-kernel@vger.kernel.org, xosview-devel@lists.sourceforge.net
Subject: Re: 2.5.70 latest: breaks gnome
Message-Id: <20030605161132.46f793e2.akpm@digeo.com>
In-Reply-To: <1054852458.1886.18.camel@wires.home.biz>
References: <20030604142241.0dc6f34e.shemminger@osdl.org>
	<3EDE7398.70005@tmsusa.com>
	<20030605111212.33e63d46.shemminger@osdl.org>
	<3EDFB3E2.2090308@tmsusa.com>
	<20030605143346.197a8923.akpm@digeo.com>
	<3EDFBD08.5060902@tmsusa.com>
	<1054852458.1886.18.camel@wires.home.biz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jun 2003 23:15:13.0667 (UTC) FILETIME=[516E5D30:01C32BB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Tandi <ed@efix.biz> wrote:
>
> 2) xosview still freezes (reading /proc/*)

OK, here's a quick hack to get xosview-1.8.0 working on 2.5.x kernels.

 xosview-1.8.0-akpm/linux/cpumeter.cc  |    5 ++++-
 xosview-1.8.0-akpm/linux/diskmeter.cc |    2 ++
 xosview-1.8.0-akpm/linux/pagemeter.cc |    2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff -puN linux/diskmeter.cc~proc-stats-hang-fix linux/diskmeter.cc
--- xosview-1.8.0/linux/diskmeter.cc~proc-stats-hang-fix	Thu Jun  5 16:02:34 2003
+++ xosview-1.8.0-akpm/linux/diskmeter.cc	Thu Jun  5 16:02:53 2003
@@ -64,6 +64,8 @@ void DiskMeter::getdiskinfo( void )
         {
         stats.ignore(1024, '\n');
         stats >> buf;
+	if (stats.eof())
+		break;
         }
 
 	// read values
diff -puN linux/cpumeter.cc~proc-stats-hang-fix linux/cpumeter.cc
--- xosview-1.8.0/linux/cpumeter.cc~proc-stats-hang-fix	Thu Jun  5 16:07:14 2003
+++ xosview-1.8.0-akpm/linux/cpumeter.cc	Thu Jun  5 16:07:42 2003
@@ -58,8 +58,11 @@ void CPUMeter::getcputime( void ){
   }
 
   // read until we are at the right line.
-  for (int i = 0 ; i < _lineNum ; i++)
+  for (int i = 0 ; i < _lineNum ; i++) {
+    if (stats.eof())
+	break;
     stats.getline(tmp, 1024);
+  }
 
   stats >>tmp >>cputime_[cpuindex_][0]  
 	      >>cputime_[cpuindex_][1]  
diff -puN linux/pagemeter.cc~proc-stats-hang-fix linux/pagemeter.cc
--- xosview-1.8.0/linux/pagemeter.cc~proc-stats-hang-fix	Thu Jun  5 16:07:55 2003
+++ xosview-1.8.0-akpm/linux/pagemeter.cc	Thu Jun  5 16:08:36 2003
@@ -58,7 +58,7 @@ void PageMeter::getpageinfo( void ){
 
   do {
     stats >>buf;
-  } while (strncasecmp(buf, "swap", 5));
+  } while (!stats.eof() && strncasecmp(buf, "swap", 5));
 	  
   stats >>pageinfo_[pageindex_][0] >>pageinfo_[pageindex_][1];
 

_

