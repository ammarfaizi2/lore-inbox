Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKDPDO>; Sat, 4 Nov 2000 10:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbQKDPDD>; Sat, 4 Nov 2000 10:03:03 -0500
Received: from [212.32.186.211] ([212.32.186.211]:54757 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129040AbQKDPCr>; Sat, 4 Nov 2000 10:02:47 -0500
Date: Sat, 4 Nov 2000 16:02:35 +0100 (CET)
From: Urban Widmark <urban@svenskatest.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [patch] fixes for smbfs readdir in 2.2.18-pre18
Message-ID: <Pine.LNX.4.21.0010312211440.29519-100000@cola.svenskatest.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello

The old problem with smbfs and listing directories continue. The change of
infolevel that was thought to fix things in 2.2.14 didn't fix everything.
Here is a patch for another thing smbfs doesn't really do right,
apparently.

There is a mismatch between the negotiated maximum transfer size and the
number of bytes smbfs tells the server it may return. This patch changes
it from using 2 completely magic values to use other magic values based on
the negotiated size.

There are mixed reports on this for some servers (OS/2 & NetApp), no luck
for AS/400 (but they send unicode stuff even when not negotiated). But it
fixes problems vs the much more common NT4 (and win2k?) servers.

I'd love to see this in 2.2.18-pre19.

/Urban


diff -ur -X exclude linux-2.2.18-pre18-orig/fs/smbfs/ChangeLog linux-2.2.18-pre18-smbfs/fs/smbfs/ChangeLog
--- linux-2.2.18-pre18-orig/fs/smbfs/ChangeLog	Sat Nov  4 11:38:56 2000
+++ linux-2.2.18-pre18-smbfs/fs/smbfs/ChangeLog	Sat Nov  4 11:59:11 2000
@@ -1,5 +1,11 @@
 ChangeLog for smbfs.
 
+2000-11-04 Urban Widmark <urban@svenskatest.se>
+
+	* proc.c, sock.c: adjust max parameters & max data to follow max_xmit
+	  lots of servers were having find_next trouble with this.
+	* proc.c: use documented write method of truncating (NetApp fix)
+
 2000-09-01 Urban Widmark <urban@svenskatest.se>
 
 	* proc.c: add back lanman2 support (OS/2 and others)
diff -ur -X exclude linux-2.2.18-pre18-orig/fs/smbfs/proc.c linux-2.2.18-pre18-smbfs/fs/smbfs/proc.c
--- linux-2.2.18-pre18-orig/fs/smbfs/proc.c	Sat Nov  4 11:38:56 2000
+++ linux-2.2.18-pre18-smbfs/fs/smbfs/proc.c	Sat Nov  4 12:07:58 2000
@@ -385,22 +385,16 @@
 }
 
 /*
- * Returns the maximum read or write size for the current packet size
- * and max_xmit value.
+ * Returns the maximum read or write size for the "payload". Making all of the
+ * packet fit within the negotiated max_xmit size.
+ *
  * N.B. Since this value is usually computed before locking the server,
  * the server's packet size must never be decreased!
  */
-static int
+static inline int
 smb_get_xmitsize(struct smb_sb_info *server, int overhead)
 {
-	int size = server->packet_size;
-
-	/*
-	 * Start with the smaller of packet size and max_xmit ...
-	 */
-	if (size > server->opt.max_xmit)
-		size = server->opt.max_xmit;
-	return size - overhead;
+	return server->opt.max_xmit - overhead;
 }
 
 /*
@@ -751,6 +745,23 @@
 		server->opt.protocol, server->opt.max_xmit, server->conn_pid,
 		server->opt.capabilities);
 
+	/* Make sure we can fit a message of the negotiated size in our
+	   packet buffer. */
+	if (server->opt.max_xmit > server->packet_size) {
+		int len = smb_round_length(server->opt.max_xmit);
+		char *buf = smb_vmalloc(len);
+		if (buf) {
+			server->packet = buf;
+			server->packet_size = len;
+		} else {
+			/* else continue with the too small buffer? */
+			PARANOIA("Failed to allocate new packet buffer: "
+				 "max_xmit=%d, packet_size=%d\n",
+				 server->opt.max_xmit, server->packet_size);
+			server->opt.max_xmit = server->packet_size;
+		}
+	}
+
 out:
 #ifdef SMB_RETRY_INTR
 	wake_up_interruptible(&server->wait);
@@ -1348,17 +1359,16 @@
 	smb_lock_server(server);
 
       retry:
-	p = smb_setup_header(server, SMBwrite, 5, 0);
+	p = smb_setup_header(server, SMBwrite, 5, 3);
 	WSET(server->packet, smb_vwv0, fid);
 	WSET(server->packet, smb_vwv1, 0);
 	DSET(server->packet, smb_vwv2, length);
 	WSET(server->packet, smb_vwv4, 0);
-	*p++ = 4;
-	*p++ = 0;
-	smb_setup_bcc(server, p);
 
-	if ((result = smb_request_ok(server, SMBwrite, 1, 0)) < 0)
-	{
+	*p++ = 1;
+	WSET(p, 0, 0);
+
+	if ((result = smb_request_ok(server, SMBwrite, 1, 0)) < 0) {
 		if (smb_retry(server))
 			goto retry;
 		goto out;
@@ -1487,8 +1497,8 @@
 smb_proc_readdir_long(struct smb_sb_info *server, struct dentry *dir, int fpos,
 		      void *cachep)
 {
-	unsigned char *p;
-	char *mask, *lastname, *param = server->temp_buf;
+	unsigned char *p, *lastname;
+	char *mask, *param = server->temp_buf;
 	__u16 command;
 	int first, entries, entries_seen;
 
@@ -1521,7 +1531,7 @@
 	 * Encode the initial path
 	 */
 	mask = param + 12;
-	mask_len = smb_encode_path(server, mask, dir, &star);
+	mask_len = smb_encode_path(server, mask, dir, &star) - 1;
 	if (mask_len < 0) {
 		entries = mask_len;
 		goto unlock_return;
@@ -1613,31 +1623,41 @@
 		if (ff_searchcount == 0)
 			break;
 
-		/* we might need the lastname for continuations */
+		/*
+		 * We might need the lastname for continuations.
+		 *
+		 * Note that some servers (win95) point to the filename and
+		 * others (NT4, Samba using NT1) to the dir entry. We assume
+		 * here that those who do not point to a filename do not need
+		 * this info to continue the listing.
+		 */
 		mask_len = 0;
-		if (ff_lastname > 0) {
+		if (ff_lastname > 0 && ff_lastname < resp_data_len) {
 			lastname = resp_data + ff_lastname;
 			switch (info_level) {
 			case 260:
-				if (ff_lastname < resp_data_len)
-					mask_len = resp_data_len - ff_lastname;
+				mask_len = resp_data_len - ff_lastname;
 				break;
 			case 1:
-				/* Win NT 4.0 doesn't set the length byte */
-				lastname++;
-				if (ff_lastname + 2 < resp_data_len)
-					mask_len = strlen(lastname);
+				/* lastname points to a length byte */
+				mask_len = *lastname++;
+				if (ff_lastname + 1 + mask_len > resp_data_len)
+					mask_len = resp_data_len - ff_lastname - 1;
 				break;
 			}
 			/*
 			 * Update the mask string for the next message.
 			 */
+			if (mask_len < 0)
+				mask_len = 0;
 			if (mask_len > 255)
 				mask_len = 255;
 			if (mask_len)
 				strncpy(mask, lastname, mask_len);
 		}
 		mask[mask_len] = 0;
+		mask_len = strlen(mask);	/* find the actual string len */
+
 
 		/* Now we are ready to parse smb directory entries. */
 
diff -ur -X exclude linux-2.2.18-pre18-orig/fs/smbfs/sock.c linux-2.2.18-pre18-smbfs/fs/smbfs/sock.c
--- linux-2.2.18-pre18-orig/fs/smbfs/sock.c	Sat Nov  4 11:38:56 2000
+++ linux-2.2.18-pre18-smbfs/fs/smbfs/sock.c	Sat Nov  4 11:52:32 2000
@@ -473,14 +473,12 @@
 	unsigned int total_p = 0, total_d = 0, buf_len = 0;
 	int result;
 
-	while (1)
-	{
+	while (1) {
 		result = smb_receive(server);
 		if (result < 0)
 			goto out;
 		inbuf = server->packet;
-		if (server->rcls != 0)
-		{
+		if (server->rcls != 0) {
 			*parm = *data = inbuf;
 			*ldata = *lparm = 0;
 			goto out;
@@ -504,13 +502,11 @@
 		parm_len += parm_count;
 		data_len += data_count;
 
-		if (!rcv_buf)
-		{
+		if (!rcv_buf) {
 			/*
 			 * Check for fast track processing ... just this packet.
 			 */
-			if (parm_count == parm_tot && data_count == data_tot)
-			{
+			if (parm_count == parm_tot && data_count == data_tot) {
 				VERBOSE("fast track, parm=%u %u %u, data=%u %u %u\n",
 					parm_disp, parm_offset, parm_count, 
 					data_disp, data_offset, data_count);
@@ -520,12 +516,10 @@
 				goto success;
 			}
 
-			if (parm_tot > TRANS2_MAX_TRANSFER ||
-	  		    data_tot > TRANS2_MAX_TRANSFER)
-				goto out_too_long;
-
 			/*
-			 * Save the total parameter and data length.
+			 * Allocate a new buffer for receiving multiple packets
+			 * into. If we stick to the negotiated max_xmit this
+			 * shouldn't have to happen.
 			 */
 			total_d = data_tot;
 			total_p = parm_tot;
@@ -534,14 +528,15 @@
 			if (server->packet_size > buf_len)
 				buf_len = server->packet_size;
 			buf_len = smb_round_length(buf_len);
+			if (buf_len > SMB_MAX_PACKET_SIZE)
+				goto out_no_mem;
 
 			rcv_buf = smb_vmalloc(buf_len);
 			if (!rcv_buf)
 				goto out_no_mem;
 			*parm = rcv_buf;
 			*data = rcv_buf + total_p;
-		}
-		else if (data_tot > total_d || parm_tot > total_p)
+		} else if (data_tot > total_d || parm_tot > total_p)
 			goto out_data_grew;
 
 		if (parm_disp + parm_count > total_p)
@@ -568,8 +563,7 @@
 	 * old one, in which case we just copy the data.
 	 */
 	inbuf = server->packet;
-	if (buf_len >= server->packet_size)
-	{
+	if (buf_len >= server->packet_size) {
 		server->packet_size = buf_len;
 		server->packet = rcv_buf;
 		rcv_buf = inbuf;
@@ -713,6 +707,7 @@
 	struct socket *sock = server_sock(server);
 	struct scm_cookie scm;
 	int err;
+	int mparam, mdata;
 
 	/* I know the following is very ugly, but I want to build the
 	   smb packet as efficiently as possible. */
@@ -733,19 +728,30 @@
 	struct iovec iov[4];
 	struct msghdr msg;
 
-	/* N.B. This test isn't valid! packet_size may be < max_xmit */
+	/* FIXME! this test needs to include SMB overhead too, I think ... */
 	if ((bcc + oparam) > server->opt.max_xmit)
-	{
 		return -ENOMEM;
-	}
 	p = smb_setup_header(server, SMBtrans2, smb_parameters, bcc);
 
+	/*
+	 * max parameters + max data + max setup == max_xmit to make NT4 happy
+	 * and not abort the transfer or split into multiple packets.
+	 *
+	 * -100 is to make room for headers, which OS/2 seems to include in the
+	 * size calculation NT4 does not?
+	 */
+	mparam = SMB_TRANS2_MAX_PARAM;
+	mdata = server->opt.max_xmit - mparam - 100;
+	if (mdata < 1024) {
+		mdata = 1024;
+		mparam = 20;
+	}
+
 	WSET(server->packet, smb_tpscnt, lparam);
 	WSET(server->packet, smb_tdscnt, ldata);
-	/* N.B. these values should reflect out current packet size */
-	WSET(server->packet, smb_mprcnt, TRANS2_MAX_TRANSFER);
-	WSET(server->packet, smb_mdrcnt, TRANS2_MAX_TRANSFER);
-	WSET(server->packet, smb_msrcnt, 0);
+	WSET(server->packet, smb_mprcnt, mparam);
+	WSET(server->packet, smb_mdrcnt, mdata);
+	WSET(server->packet, smb_msrcnt, 0);	/* max setup always 0 ? */
 	WSET(server->packet, smb_flags, 0);
 	DSET(server->packet, smb_timeout, 0);
 	WSET(server->packet, smb_pscnt, lparam);
@@ -777,8 +783,7 @@
 	iov[3].iov_len = ldata;
 
 	err = scm_send(sock, &msg, &scm);
-        if (err >= 0)
-	{
+        if (err >= 0) {
 		err = sock->ops->sendmsg(sock, &msg, packet_length, &scm);
 		scm_destroy(&scm);
 	}
diff -ur -X exclude linux-2.2.18-pre18-orig/include/linux/smb.h linux-2.2.18-pre18-smbfs/include/linux/smb.h
--- linux-2.2.18-pre18-orig/include/linux/smb.h	Sat Nov  4 11:38:57 2000
+++ linux-2.2.18-pre18-smbfs/include/linux/smb.h	Sat Nov  4 12:20:57 2000
@@ -119,11 +119,13 @@
 
 #define SMB_HEADER_LEN   37     /* includes everything up to, but not
                                  * including smb_bcc */
-#define SMB_DEF_MAX_XMIT 32768
-#define SMB_INITIAL_PACKET_SIZE 4000
 
-/* Allocate max. 1 page */
-#define TRANS2_MAX_TRANSFER (4096-17)
+#define SMB_INITIAL_PACKET_SIZE	4000
+#define SMB_MAX_PACKET_SIZE	32768
+
+/* reserve this much space for trans2 parameters. Shouldn't have to be more
+   than 10 or so, but OS/2 seems happier like this. */
+#define SMB_TRANS2_MAX_PARAM 64
 
 #endif
 #endif

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
