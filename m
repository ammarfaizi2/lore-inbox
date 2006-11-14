Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966264AbWKNSdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966264AbWKNSdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966266AbWKNSdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:33:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28166 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966264AbWKNSdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:33:19 -0500
Date: Tue, 14 Nov 2006 19:33:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Steven Whitehouse <swhiteho@redhat.com>,
       pcaulfie@redhat.com, teigland@redhat.com
Cc: linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: [-mm patch] fix the DLM dependencies.
Message-ID: <20061114183324.GL22565@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> - A nasty Kconfig warning comes out during the build.  It's due to
>   git-gfs2-nmw.patch.
>...

So let's fix it.  ;-)

cu
Adrian


<--  snip  -->


Kconfig said:
Warning! Found recursive dependency: INET IPV6 DLM (null) DLM_TCP INET

Due to the "depends on IPV6 || IPV6=n" it's not really a circular 
dependency, but there's another bug that anyway should be fixed:
The "select IP_SCTP" ignored the dependency of IP_SCTP on INET.

Considering that:
- there's no way to use DLM with INET=n and
- INET=n being a mostly pathological case
this patch fixes both this bug and the "recursive dependency" warning by 
letting DLM depend on INET again.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/fs/dlm/Kconfig.old	2006-11-14 18:41:35.000000000 +0100
+++ linux-2.6.19-rc5-mm2/fs/dlm/Kconfig	2006-11-14 18:44:12.000000000 +0100
@@ -1,5 +1,5 @@
 menu "Distributed Lock Manager"
-	depends on EXPERIMENTAL
+	depends on EXPERIMENTAL && INET
 
 config DLM
 	tristate "Distributed Lock Manager (DLM)"
@@ -20,7 +20,6 @@ choice
 
 config DLM_TCP
 	bool "TCP/IP"
-	select INET
 
 config DLM_SCTP
 	bool "SCTP"

