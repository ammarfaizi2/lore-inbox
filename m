Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWDMXMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWDMXMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWDMXLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:11:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:7887 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965018AbWDMXKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:10:18 -0400
Date: Thu, 13 Apr 2006 16:09:16 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Steve French <sfrench@us.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 18/22] Incorrect signature sent on SMB Read
Message-ID: <20060413230916.GS5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="CIFS-Incorrect-signature-sent-on-SMB-Read.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
Fixes Samba bug 3621 and kernel.org bug 6147

For servers which require SMB/CIFS packet signing, we were sending the
wrong signature (all zeros) on SMB Read request.  The new cifs routine
to do signatures across an iovec was not complete - and SMB Read, unlike
the new SMBWrite2, did not fall back to the older routine (ie use
SendReceive vs. the more efficient SendReceive2 ie used the older
cifs_sign_smb vs. the disabled  cifs_sign_smb2) for calculating signatures.

This finishes up cifs_sign_smb2/cifs_calc_signature2 so that the callers
of SendReceive2 can get SMB/CIFS packet signatures.

Now that cifs_sign_smb2 is supported, we could start using it in
the write path but this smaller fix does not include the change
to use SMBWrite2 when signatures are required (which when enabled
will make more Writes more efficient and alloc less memory).
Currently Write2 is only used when signatures are not
required at the moment but after more testing we will enable
that as well).

Thanks to James Slepicka and Sam Flory for initial investigation.

Signed-off-by: Steve French <sfrench@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/cifs/cifsencrypt.c |   36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

--- linux-2.6.16.5.orig/fs/cifs/cifsencrypt.c
+++ linux-2.6.16.5/fs/cifs/cifsencrypt.c
@@ -56,9 +56,6 @@ int cifs_sign_smb(struct smb_hdr * cifs_
 	int rc = 0;
 	char smb_signature[20];
 
-	/* BB remember to initialize sequence number elsewhere and initialize mac_signing key elsewhere BB */
-	/* BB remember to add code to save expected sequence number in midQ entry BB */
-
 	if((cifs_pdu == NULL) || (server == NULL))
 		return -EINVAL;
 
@@ -85,20 +82,33 @@ int cifs_sign_smb(struct smb_hdr * cifs_
 static int cifs_calc_signature2(const struct kvec * iov, int n_vec,
 				const char * key, char * signature)
 {
-        struct  MD5Context context;
-
-        if((iov == NULL) || (signature == NULL))
-                return -EINVAL;
+	struct  MD5Context context;
+	int i;
 
-        MD5Init(&context);
-        MD5Update(&context,key,CIFS_SESSION_KEY_SIZE+16);
+	if((iov == NULL) || (signature == NULL))
+		return -EINVAL;
 
-/*        MD5Update(&context,cifs_pdu->Protocol,cifs_pdu->smb_buf_length); */ /* BB FIXME BB */
+	MD5Init(&context);
+	MD5Update(&context,key,CIFS_SESSION_KEY_SIZE+16);
+	for(i=0;i<n_vec;i++) {
+		if(iov[i].iov_base == NULL) {
+			cERROR(1,("null iovec entry"));
+			return -EIO;
+		} else if(iov[i].iov_len == 0)
+			break; /* bail out if we are sent nothing to sign */
+		/* The first entry includes a length field (which does not get
+		   signed that occupies the first 4 bytes before the header */
+		if(i==0) {
+			if (iov[0].iov_len <= 8 ) /* cmd field at offset 9 */
+				break; /* nothing to sign or corrupt header */
+			MD5Update(&context,iov[0].iov_base+4, iov[0].iov_len-4);
+		} else
+			MD5Update(&context,iov[i].iov_base, iov[i].iov_len);
+	}
 
-        MD5Final(signature,&context);
+	MD5Final(signature,&context);
 
-	return -EOPNOTSUPP;
-/*        return 0; */
+	return 0;
 }
 
 

--
