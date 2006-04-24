Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWDXUwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWDXUwf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWDXUwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:52:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46722 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751169AbWDXUwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:52:34 -0400
Date: Mon, 24 Apr 2006 16:52:11 -0400
From: Dave Jones <davej@redhat.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Steve French <sfrench@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix cifs breakage when CONFIG_CIFS_EXPERIMENTAL=n
Message-ID: <20060424205211.GD7385@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jean Delvare <khali@linux-fr.org>,
	Steve French <sfrench@us.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <20060424222539.1d3c96fd.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424222539.1d3c96fd.khali@linux-fr.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 10:25:39PM +0200, Jean Delvare wrote:
 > Hi Steve,
 > 
 > Cifs is currently broken when CONFIG_CIFS_EXPERIMENTAL=n:
 > 
 > The following patch attempts to fix that. Untested beyond compilation.

I fixed it with a smaller equally untested patch:

Signed-off-by: Dave Jones <davej@redhat.com>

fs/cifs/connect.c: In function 'cifs_setup_session':
fs/cifs/connect.c:3451: error: implicit declaration of function 'CIFS_SessSetup'

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.16.noarch/fs/cifs/connect.c~	2006-04-23 23:08:32.000000000 -0400
+++ linux-2.6.16.noarch/fs/cifs/connect.c	2006-04-23 23:09:45.000000000 -0400
@@ -3447,10 +3447,13 @@ int cifs_setup_session(unsigned int xid,
 			pSesInfo->server->secMode,
 			pSesInfo->server->capabilities,
 			pSesInfo->server->timeZone));
+#ifdef CONFIG_CIFS_EXPERIMENTAL
 		if(experimEnabled > 1)
 			rc = CIFS_SessSetup(xid, pSesInfo, CIFS_NTLM /* type */,
-					    &ntlmv2_flag, nls_info);	
-		else if (extended_security
+					    &ntlmv2_flag, nls_info);
+		else
+#endif
+			if (extended_security
 				&& (pSesInfo->capabilities & CAP_EXTENDED_SECURITY)
 				&& (pSesInfo->server->secType == NTLMSSP)) {
 			cFYI(1, ("New style sesssetup"));
-- 
http://www.codemonkey.org.uk
