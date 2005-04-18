Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVDRBwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVDRBwn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 21:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVDRBwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 21:52:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46598 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261588AbVDRBwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 21:52:06 -0400
Date: Mon, 18 Apr 2005 03:52:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: sfrench@samba.org
Cc: samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove cifs_kcalloc
Message-ID: <20050418015202.GA3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes cifs_kcalloc and replaces it with calls to
kcalloc(1, ...) .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/cifs/connect.c |   92 ++++++++++++++++++++--------------------------
 1 files changed, 41 insertions(+), 51 deletions(-)

--- linux-2.6.12-rc2-mm3-full/fs/cifs/connect.c.old	2005-04-18 03:00:31.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/cifs/connect.c	2005-04-18 03:02:18.000000000 +0200
@@ -471,16 +471,6 @@
 	return 0;
 }
 
-static void * 
-cifs_kcalloc(size_t size, unsigned int __nocast type)
-{
-	void *addr;
-	addr = kmalloc(size, type);
-	if (addr)
-		memset(addr, 0, size);
-	return addr;
-}
-
 static int
 cifs_parse_mount_options(char *options, const char *devname,struct smb_vol *vol)
 {
@@ -598,7 +588,7 @@
 				/* go from value to value + temp_len condensing 
 				double commas to singles. Note that this ends up
 				allocating a few bytes too many, which is ok */
-				vol->password = cifs_kcalloc(temp_len, GFP_KERNEL);
+				vol->password = kcalloc(1, temp_len, GFP_KERNEL);
 				for(i=0,j=0;i<temp_len;i++,j++) {
 					vol->password[j] = value[i];
 					if(value[i] == separator[0] && value[i+1] == separator[0]) {
@@ -608,7 +598,7 @@
 				}
 				vol->password[j] = 0;
 			} else {
-				vol->password = cifs_kcalloc(temp_len + 1, GFP_KERNEL);
+				vol->password = kcalloc(1, temp_len + 1, GFP_KERNEL);
 				strcpy(vol->password, value);
 			}
 		} else if (strnicmp(data, "ip", 2) == 0) {
@@ -1070,7 +1060,7 @@
 		sessinit is sent but no second negprot */
 		struct rfc1002_session_packet * ses_init_buf;
 		struct smb_hdr * smb_buf;
-		ses_init_buf = cifs_kcalloc(sizeof(struct rfc1002_session_packet), GFP_KERNEL);
+		ses_init_buf = kcalloc(1, sizeof(struct rfc1002_session_packet), GFP_KERNEL);
 		if(ses_init_buf) {
 			ses_init_buf->trailer.session_req.called_len = 32;
 			rfc1002mangle(ses_init_buf->trailer.session_req.called_name,
@@ -1717,7 +1707,7 @@
 /* We look for obvious messed up bcc or strings in response so we do not go off
    the end since (at least) WIN2K and Windows XP have a major bug in not null
    terminating last Unicode string in response  */
-				ses->serverOS = cifs_kcalloc(2 * (len + 1), GFP_KERNEL);
+				ses->serverOS = kcalloc(1, 2 * (len + 1), GFP_KERNEL);
 				cifs_strfromUCS_le(ses->serverOS,
 					   (wchar_t *)bcc_ptr, len,nls_codepage);
 				bcc_ptr += 2 * (len + 1);
@@ -1727,7 +1717,7 @@
 				if (remaining_words > 0) {
 					len = UniStrnlen((wchar_t *)bcc_ptr,
 							 remaining_words-1);
-					ses->serverNOS =cifs_kcalloc(2 * (len + 1),GFP_KERNEL);
+					ses->serverNOS =kcalloc(1, 2 * (len + 1),GFP_KERNEL);
 					cifs_strfromUCS_le(ses->serverNOS,
 							   (wchar_t *)bcc_ptr,len,nls_codepage);
 					bcc_ptr += 2 * (len + 1);
@@ -1743,7 +1733,7 @@
 						len = UniStrnlen((wchar_t *) bcc_ptr, remaining_words);	
           /* last string is not always null terminated (for e.g. for Windows XP & 2000) */
 						ses->serverDomain =
-						    cifs_kcalloc(2*(len+1),GFP_KERNEL);
+						    kcalloc(1, 2*(len+1),GFP_KERNEL);
 						cifs_strfromUCS_le(ses->serverDomain,
 						     (wchar_t *)bcc_ptr,len,nls_codepage);
 						bcc_ptr += 2 * (len + 1);
@@ -1752,20 +1742,20 @@
 					} /* else no more room so create dummy domain string */
 					else
 						ses->serverDomain =
-						    cifs_kcalloc(2,
+						    kcalloc(1, 2,
 							    GFP_KERNEL);
 				} else {	/* no room so create dummy domain and NOS string */
 					ses->serverDomain =
-					    cifs_kcalloc(2, GFP_KERNEL);
+					    kcalloc(1, 2, GFP_KERNEL);
 					ses->serverNOS =
-					    cifs_kcalloc(2, GFP_KERNEL);
+					    kcalloc(1, 2, GFP_KERNEL);
 				}
 			} else {	/* ASCII */
 				len = strnlen(bcc_ptr, 1024);
 				if (((long) bcc_ptr + len) - (long)
 				    pByteArea(smb_buffer_response)
 					    <= BCC(smb_buffer_response)) {
-					ses->serverOS = cifs_kcalloc(len + 1,GFP_KERNEL);
+					ses->serverOS = kcalloc(1, len + 1,GFP_KERNEL);
 					strncpy(ses->serverOS,bcc_ptr, len);
 
 					bcc_ptr += len;
@@ -1773,14 +1763,14 @@
 					bcc_ptr++;
 
 					len = strnlen(bcc_ptr, 1024);
-					ses->serverNOS = cifs_kcalloc(len + 1,GFP_KERNEL);
+					ses->serverNOS = kcalloc(1, len + 1,GFP_KERNEL);
 					strncpy(ses->serverNOS, bcc_ptr, len);
 					bcc_ptr += len;
 					bcc_ptr[0] = 0;
 					bcc_ptr++;
 
 					len = strnlen(bcc_ptr, 1024);
-					ses->serverDomain = cifs_kcalloc(len + 1,GFP_KERNEL);
+					ses->serverDomain = kcalloc(1, len + 1,GFP_KERNEL);
 					strncpy(ses->serverDomain, bcc_ptr, len);
 					bcc_ptr += len;
 					bcc_ptr[0] = 0;
@@ -1977,7 +1967,7 @@
    the end since (at least) WIN2K and Windows XP have a major bug in not null
    terminating last Unicode string in response  */
 					ses->serverOS =
-					    cifs_kcalloc(2 * (len + 1), GFP_KERNEL);
+					    kcalloc(1, 2 * (len + 1), GFP_KERNEL);
 					cifs_strfromUCS_le(ses->serverOS,
 							   (wchar_t *)
 							   bcc_ptr, len,
@@ -1991,7 +1981,7 @@
 								 remaining_words
 								 - 1);
 						ses->serverNOS =
-						    cifs_kcalloc(2 * (len + 1),
+						    kcalloc(1, 2 * (len + 1),
 							    GFP_KERNEL);
 						cifs_strfromUCS_le(ses->serverNOS,
 								   (wchar_t *)bcc_ptr,
@@ -2004,7 +1994,7 @@
 						if (remaining_words > 0) {
 							len = UniStrnlen((wchar_t *) bcc_ptr, remaining_words);	
                             /* last string is not always null terminated (for e.g. for Windows XP & 2000) */
-							ses->serverDomain = cifs_kcalloc(2*(len+1),GFP_KERNEL);
+							ses->serverDomain = kcalloc(1, 2*(len+1),GFP_KERNEL);
 							cifs_strfromUCS_le(ses->serverDomain,
 							     (wchar_t *)bcc_ptr, 
                                  len,
@@ -2015,10 +2005,10 @@
 						} /* else no more room so create dummy domain string */
 						else
 							ses->serverDomain =
-							    cifs_kcalloc(2,GFP_KERNEL);
+							    kcalloc(1, 2,GFP_KERNEL);
 					} else {	/* no room so create dummy domain and NOS string */
-						ses->serverDomain = cifs_kcalloc(2, GFP_KERNEL);
-						ses->serverNOS = cifs_kcalloc(2, GFP_KERNEL);
+						ses->serverDomain = kcalloc(1, 2, GFP_KERNEL);
+						ses->serverNOS = kcalloc(1, 2, GFP_KERNEL);
 					}
 				} else {	/* ASCII */
 
@@ -2026,7 +2016,7 @@
 					if (((long) bcc_ptr + len) - (long)
 					    pByteArea(smb_buffer_response)
 					    <= BCC(smb_buffer_response)) {
-						ses->serverOS = cifs_kcalloc(len + 1, GFP_KERNEL);
+						ses->serverOS = kcalloc(1, len + 1, GFP_KERNEL);
 						strncpy(ses->serverOS, bcc_ptr, len);
 
 						bcc_ptr += len;
@@ -2034,14 +2024,14 @@
 						bcc_ptr++;
 
 						len = strnlen(bcc_ptr, 1024);
-						ses->serverNOS = cifs_kcalloc(len + 1,GFP_KERNEL);
+						ses->serverNOS = kcalloc(1, len + 1,GFP_KERNEL);
 						strncpy(ses->serverNOS, bcc_ptr, len);
 						bcc_ptr += len;
 						bcc_ptr[0] = 0;
 						bcc_ptr++;
 
 						len = strnlen(bcc_ptr, 1024);
-						ses->serverDomain = cifs_kcalloc(len + 1, GFP_KERNEL);
+						ses->serverDomain = kcalloc(1, len + 1, GFP_KERNEL);
 						strncpy(ses->serverDomain, bcc_ptr, len);
 						bcc_ptr += len;
 						bcc_ptr[0] = 0;
@@ -2291,7 +2281,7 @@
    the end since (at least) WIN2K and Windows XP have a major bug in not null
    terminating last Unicode string in response  */
 					ses->serverOS =
-					    cifs_kcalloc(2 * (len + 1), GFP_KERNEL);
+					    kcalloc(1, 2 * (len + 1), GFP_KERNEL);
 					cifs_strfromUCS_le(ses->serverOS,
 							   (wchar_t *)
 							   bcc_ptr, len,
@@ -2306,7 +2296,7 @@
 								 remaining_words
 								 - 1);
 						ses->serverNOS =
-						    cifs_kcalloc(2 * (len + 1),
+						    kcalloc(1, 2 * (len + 1),
 							    GFP_KERNEL);
 						cifs_strfromUCS_le(ses->
 								   serverNOS,
@@ -2323,7 +2313,7 @@
 							len = UniStrnlen((wchar_t *) bcc_ptr, remaining_words);	
            /* last string is not always null terminated (for e.g. for Windows XP & 2000) */
 							ses->serverDomain =
-							    cifs_kcalloc(2 *
+							    kcalloc(1, 2 *
 								    (len +
 								     1),
 								    GFP_KERNEL);
@@ -2349,13 +2339,13 @@
 						} /* else no more room so create dummy domain string */
 						else
 							ses->serverDomain =
-							    cifs_kcalloc(2,
+							    kcalloc(1, 2,
 								    GFP_KERNEL);
 					} else {	/* no room so create dummy domain and NOS string */
 						ses->serverDomain =
-						    cifs_kcalloc(2, GFP_KERNEL);
+						    kcalloc(1, 2, GFP_KERNEL);
 						ses->serverNOS =
-						    cifs_kcalloc(2, GFP_KERNEL);
+						    kcalloc(1, 2, GFP_KERNEL);
 					}
 				} else {	/* ASCII */
 					len = strnlen(bcc_ptr, 1024);
@@ -2363,7 +2353,7 @@
 					    pByteArea(smb_buffer_response)
 					    <= BCC(smb_buffer_response)) {
 						ses->serverOS =
-						    cifs_kcalloc(len + 1,
+						    kcalloc(1, len + 1,
 							    GFP_KERNEL);
 						strncpy(ses->serverOS,
 							bcc_ptr, len);
@@ -2374,7 +2364,7 @@
 
 						len = strnlen(bcc_ptr, 1024);
 						ses->serverNOS =
-						    cifs_kcalloc(len + 1,
+						    kcalloc(1, len + 1,
 							    GFP_KERNEL);
 						strncpy(ses->serverNOS, bcc_ptr, len);
 						bcc_ptr += len;
@@ -2383,7 +2373,7 @@
 
 						len = strnlen(bcc_ptr, 1024);
 						ses->serverDomain =
-						    cifs_kcalloc(len + 1,
+						    kcalloc(1, len + 1,
 							    GFP_KERNEL);
 						strncpy(ses->serverDomain, bcc_ptr, len);	
 						bcc_ptr += len;
@@ -2685,7 +2675,7 @@
   the end since (at least) WIN2K and Windows XP have a major bug in not null
   terminating last Unicode string in response  */
 					ses->serverOS =
-					    cifs_kcalloc(2 * (len + 1), GFP_KERNEL);
+					    kcalloc(1, 2 * (len + 1), GFP_KERNEL);
 					cifs_strfromUCS_le(ses->serverOS,
 							   (wchar_t *)
 							   bcc_ptr, len,
@@ -2700,7 +2690,7 @@
 								 remaining_words
 								 - 1);
 						ses->serverNOS =
-						    cifs_kcalloc(2 * (len + 1),
+						    kcalloc(1, 2 * (len + 1),
 							    GFP_KERNEL);
 						cifs_strfromUCS_le(ses->
 								   serverNOS,
@@ -2716,7 +2706,7 @@
 							len = UniStrnlen((wchar_t *) bcc_ptr, remaining_words);	
      /* last string not always null terminated (e.g. for Windows XP & 2000) */
 							ses->serverDomain =
-							    cifs_kcalloc(2 *
+							    kcalloc(1, 2 *
 								    (len +
 								     1),
 								    GFP_KERNEL);
@@ -2741,17 +2731,17 @@
 							    = 0;
 						} /* else no more room so create dummy domain string */
 						else
-							ses->serverDomain = cifs_kcalloc(2,GFP_KERNEL);
+							ses->serverDomain = kcalloc(1, 2,GFP_KERNEL);
 					} else {  /* no room so create dummy domain and NOS string */
-						ses->serverDomain = cifs_kcalloc(2, GFP_KERNEL);
-						ses->serverNOS = cifs_kcalloc(2, GFP_KERNEL);
+						ses->serverDomain = kcalloc(1, 2, GFP_KERNEL);
+						ses->serverNOS = kcalloc(1, 2, GFP_KERNEL);
 					}
 				} else {	/* ASCII */
 					len = strnlen(bcc_ptr, 1024);
 					if (((long) bcc_ptr + len) - 
                         (long) pByteArea(smb_buffer_response) 
                             <= BCC(smb_buffer_response)) {
-						ses->serverOS = cifs_kcalloc(len + 1,GFP_KERNEL);
+						ses->serverOS = kcalloc(1, len + 1,GFP_KERNEL);
 						strncpy(ses->serverOS,bcc_ptr, len);
 
 						bcc_ptr += len;
@@ -2759,14 +2749,14 @@
 						bcc_ptr++;
 
 						len = strnlen(bcc_ptr, 1024);
-						ses->serverNOS = cifs_kcalloc(len+1,GFP_KERNEL);
+						ses->serverNOS = kcalloc(1, len+1,GFP_KERNEL);
 						strncpy(ses->serverNOS, bcc_ptr, len);	
 						bcc_ptr += len;
 						bcc_ptr[0] = 0;
 						bcc_ptr++;
 
 						len = strnlen(bcc_ptr, 1024);
-						ses->serverDomain = cifs_kcalloc(len+1,GFP_KERNEL);
+						ses->serverDomain = kcalloc(1, len+1,GFP_KERNEL);
 						strncpy(ses->serverDomain, bcc_ptr, len);
 						bcc_ptr += len;
 						bcc_ptr[0] = 0;
@@ -2878,7 +2868,7 @@
 				if(tcon->nativeFileSystem)
 					kfree(tcon->nativeFileSystem);
 				tcon->nativeFileSystem =
-				    cifs_kcalloc(length + 2, GFP_KERNEL);
+				    kcalloc(1, length + 2, GFP_KERNEL);
 				cifs_strfromUCS_le(tcon->nativeFileSystem,
 						   (wchar_t *) bcc_ptr,
 						   length, nls_codepage);
@@ -2896,7 +2886,7 @@
 				if(tcon->nativeFileSystem)
 					kfree(tcon->nativeFileSystem);
 				tcon->nativeFileSystem =
-				    cifs_kcalloc(length + 1, GFP_KERNEL);
+				    kcalloc(1, length + 1, GFP_KERNEL);
 				strncpy(tcon->nativeFileSystem, bcc_ptr,
 					length);
 			}

