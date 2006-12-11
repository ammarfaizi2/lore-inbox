Return-Path: <linux-kernel-owner+w=401wt.eu-S1761271AbWLKT4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761271AbWLKT4V (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762255AbWLKT4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:56:21 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:45010 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761271AbWLKT4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:56:20 -0500
Date: Mon, 11 Dec 2006 20:56:28 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211195628.GA19889@aepfle.de>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org> <20061211182908.GC7256@MAIL.13thfloor.at> <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org> <457DAF99.4050106@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <457DAF99.4050106@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, Andy Whitcroft wrote:

> I am afraid to report that this second version also fails for me, as you 
> point out CIFS can break us if defined.  In fact we used to get away 
> with this on my test system due to ordering magic luck, I presume the 
> move to __initdata has triggered this.  Much as I agree that this is 
> wrong we are still going to break people with this.

I'm looking at cifs_strtoUCS and wonder if its safe to check 'len &&
*from'. IF it really is, the functions could snprintf to the stack and
pass this to cifs_strtoUCS.

Quick, compile tested, patch below.


Index: linux-2.6/fs/cifs/connect.c
===================================================================
--- linux-2.6.orig/fs/cifs/connect.c
+++ linux-2.6/fs/cifs/connect.c
@@ -2070,6 +2070,7 @@ CIFSSessSetup(unsigned int xid, struct c
 	      char session_key[CIFS_SESS_KEY_SIZE],
 	      const struct nls_table *nls_codepage)
 {
+	char banner[2*32+1];
 	struct smb_hdr *smb_buffer;
 	struct smb_hdr *smb_buffer_response;
 	SESSION_SETUP_ANDX *pSMB;
@@ -2135,6 +2136,8 @@ CIFSSessSetup(unsigned int xid, struct c
 	memcpy(bcc_ptr, (char *) session_key, CIFS_SESS_KEY_SIZE);
 	bcc_ptr += CIFS_SESS_KEY_SIZE;
 
+	snprintf(banner, sizeof(banner), "%s version %s", utsname()->sysname,
+		utsname()->release);
 	if (ses->capabilities & CAP_UNICODE) {
 		if ((long) bcc_ptr % 2) { /* must be word aligned for Unicode */
 			*bcc_ptr = 0;
@@ -2160,12 +2163,8 @@ CIFSSessSetup(unsigned int xid, struct c
 		bcc_ptr += 2 * bytes_returned;
 		bcc_ptr += 2;
 		bytes_returned =
-		    cifs_strtoUCS((__le16 *) bcc_ptr, "Linux version ",
-				  32, nls_codepage);
-		bcc_ptr += 2 * bytes_returned;
-		bytes_returned =
-		    cifs_strtoUCS((__le16 *) bcc_ptr, utsname()->release,
-				  32, nls_codepage);
+		    cifs_strtoUCS((__le16 *) bcc_ptr, banner,
+				  64, nls_codepage);
 		bcc_ptr += 2 * bytes_returned;
 		bcc_ptr += 2;
 		bytes_returned =
@@ -2189,10 +2188,8 @@ CIFSSessSetup(unsigned int xid, struct c
 			*bcc_ptr = 0;
 			bcc_ptr++;
 		}
-		strcpy(bcc_ptr, "Linux version ");
-		bcc_ptr += strlen("Linux version ");
-		strcpy(bcc_ptr, utsname()->release);
-		bcc_ptr += strlen(utsname()->release) + 1;
+		strcpy(bcc_ptr, banner);
+		bcc_ptr += strlen(banner) + 1;
 		strcpy(bcc_ptr, CIFS_NETWORK_OPSYS);
 		bcc_ptr += strlen(CIFS_NETWORK_OPSYS) + 1;
 	}
@@ -2360,6 +2357,7 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 			      struct cifsSesInfo *ses, int * pNTLMv2_flag,
 			      const struct nls_table *nls_codepage)
 {
+	char banner[2*32+1];
 	struct smb_hdr *smb_buffer;
 	struct smb_hdr *smb_buffer_response;
 	SESSION_SETUP_ANDX *pSMB;
@@ -2445,6 +2443,8 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 	SecurityBlob->DomainName.Buffer = 0;
 	SecurityBlob->DomainName.Length = 0;
 	SecurityBlob->DomainName.MaximumLength = 0;
+	snprintf(banner, sizeof(banner), "%s version %s", utsname()->sysname,
+		utsname()->release);
 	if (ses->capabilities & CAP_UNICODE) {
 		if ((long) bcc_ptr % 2) {
 			*bcc_ptr = 0;
@@ -2452,11 +2452,7 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 		}
 
 		bytes_returned =
-		    cifs_strtoUCS((__le16 *) bcc_ptr, "Linux version ",
-				  32, nls_codepage);
-		bcc_ptr += 2 * bytes_returned;
-		bytes_returned =
-		    cifs_strtoUCS((__le16 *) bcc_ptr, utsname()->release, 32,
+		    cifs_strtoUCS((__le16 *) bcc_ptr, banner, 64,
 				  nls_codepage);
 		bcc_ptr += 2 * bytes_returned;
 		bcc_ptr += 2;	/* null terminate Linux version */
@@ -2471,10 +2467,8 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 		*(bcc_ptr + 2) = 0;
 		bcc_ptr += 2;	/* null domain */
 	} else {		/* ASCII */
-		strcpy(bcc_ptr, "Linux version ");
-		bcc_ptr += strlen("Linux version ");
-		strcpy(bcc_ptr, utsname()->release);
-		bcc_ptr += strlen(utsname()->release) + 1;
+		strcpy(bcc_ptr, banner);
+		bcc_ptr += strlen(banner) + 1;
 		strcpy(bcc_ptr, CIFS_NETWORK_OPSYS);
 		bcc_ptr += strlen(CIFS_NETWORK_OPSYS) + 1;
 		bcc_ptr++;	/* empty domain field */
@@ -2694,6 +2688,7 @@ CIFSNTLMSSPAuthSessSetup(unsigned int xi
 		char *ntlm_session_key, int ntlmv2_flag,
 		const struct nls_table *nls_codepage)
 {
+	char banner[2*32+1];
 	struct smb_hdr *smb_buffer;
 	struct smb_hdr *smb_buffer_response;
 	SESSION_SETUP_ANDX *pSMB;
@@ -2792,6 +2787,8 @@ CIFSNTLMSSPAuthSessSetup(unsigned int xi
 	SecurityBlobLength += CIFS_SESS_KEY_SIZE;
 	bcc_ptr += CIFS_SESS_KEY_SIZE;
 
+	snprintf(banner, sizeof(banner), "%s version %s", utsname()->sysname,
+		utsname()->release);
 	if (ses->capabilities & CAP_UNICODE) {
 		if (domain == NULL) {
 			SecurityBlob->DomainName.Buffer = 0;
@@ -2843,11 +2840,7 @@ CIFSNTLMSSPAuthSessSetup(unsigned int xi
 			bcc_ptr++;
 		}
 		bytes_returned =
-		    cifs_strtoUCS((__le16 *) bcc_ptr, "Linux version ",
-				  32, nls_codepage);
-		bcc_ptr += 2 * bytes_returned;
-		bytes_returned =
-		    cifs_strtoUCS((__le16 *) bcc_ptr, utsname()->release, 32,
+		    cifs_strtoUCS((__le16 *) bcc_ptr, banner, 64,
 				  nls_codepage);
 		bcc_ptr += 2 * bytes_returned;
 		bcc_ptr += 2;	/* null term version string */
@@ -2897,10 +2890,8 @@ CIFSNTLMSSPAuthSessSetup(unsigned int xi
 		}
 		/* BB fill in our workstation name if known BB */
 
-		strcpy(bcc_ptr, "Linux version ");
-		bcc_ptr += strlen("Linux version ");
-		strcpy(bcc_ptr, utsname()->release);
-		bcc_ptr += strlen(utsname()->release) + 1;
+		strcpy(bcc_ptr, banner);
+		bcc_ptr += strlen(banner) + 1;
 		strcpy(bcc_ptr, CIFS_NETWORK_OPSYS);
 		bcc_ptr += strlen(CIFS_NETWORK_OPSYS) + 1;
 		bcc_ptr++;	/* null domain */
Index: linux-2.6/fs/cifs/sess.c
===================================================================
--- linux-2.6.orig/fs/cifs/sess.c
+++ linux-2.6/fs/cifs/sess.c
@@ -77,6 +77,7 @@ static __u32 cifs_ssetup_hdr(struct cifs
 static void unicode_ssetup_strings(char ** pbcc_area, struct cifsSesInfo *ses,
 			    const struct nls_table * nls_cp)
 {
+	char banner[2*32+1];
 	char * bcc_ptr = *pbcc_area;
 	int bytes_ret = 0;
 
@@ -113,12 +114,11 @@ static void unicode_ssetup_strings(char 
 	bcc_ptr += 2;  /* account for null terminator */
 
 	/* Copy OS version */
-	bytes_ret = cifs_strtoUCS((__le16 *)bcc_ptr, "Linux version ", 32,
+	snprintf(banner, sizeof(banner), "%s version %s", utsname()->sysname,
+		init_utsname()->release);
+	bytes_ret = cifs_strtoUCS((__le16 *)bcc_ptr, banner, 32,
 				  nls_cp);
 	bcc_ptr += 2 * bytes_ret;
-	bytes_ret = cifs_strtoUCS((__le16 *) bcc_ptr, init_utsname()->release,
-				  32, nls_cp);
-	bcc_ptr += 2 * bytes_ret;
 	bcc_ptr += 2; /* trailing null */
 
 	bytes_ret = cifs_strtoUCS((__le16 *) bcc_ptr, CIFS_NETWORK_OPSYS,
@@ -132,6 +132,7 @@ static void unicode_ssetup_strings(char 
 static void ascii_ssetup_strings(char ** pbcc_area, struct cifsSesInfo *ses,
 			  const struct nls_table * nls_cp)
 {
+	char banner[2*32+1];
 	char * bcc_ptr = *pbcc_area;
 
 	/* copy user */
@@ -159,10 +160,10 @@ static void ascii_ssetup_strings(char **
 
 	/* BB check for overflow here */
 
-	strcpy(bcc_ptr, "Linux version ");
-	bcc_ptr += strlen("Linux version ");
-	strcpy(bcc_ptr, init_utsname()->release);
-	bcc_ptr += strlen(init_utsname()->release) + 1;
+	snprintf(banner, sizeof(banner), "%s version %s", utsname()->sysname,
+		init_utsname()->release);
+	strcpy(bcc_ptr, banner);
+	bcc_ptr += strlen(banner) + 1;
 
 	strcpy(bcc_ptr, CIFS_NETWORK_OPSYS);
 	bcc_ptr += strlen(CIFS_NETWORK_OPSYS) + 1;
