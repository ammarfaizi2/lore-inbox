Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270850AbTHFU0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270926AbTHFU0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:26:12 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:50293 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S270850AbTHFUZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:25:43 -0400
Message-ID: <3F316446.3020808@RedHat.com>
Date: Wed, 06 Aug 2003 16:25:42 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: util-linux@math.uio.no
CC: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: NFS Mount Patch: Making NFS over TCP the default
Content-Type: multipart/mixed;
 boundary="------------020601020503030005020209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020601020503030005020209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This patch changes the default transport of NFS mounts
from UDP to TCP, iff the transport not explicitly
specified and the server support TCP mounts.

This patch is backwards compatible with servers that
don't support TCP mounts since it quarries the server
(which was already happening for the mount version)
to see if the server support TCP mounts.


SteveD.




--------------020601020503030005020209
Content-Type: text/plain;
 name="util-linux-2.11y-mount-nfs-v3tcp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="util-linux-2.11y-mount-nfs-v3tcp.patch"

--- util-linux-2.11y/mount/nfsmount.c.diff	2003-08-05 09:26:14.000000000 -0400
+++ util-linux-2.11y/mount/nfsmount.c	2003-08-05 10:47:41.000000000 -0400
@@ -133,6 +133,52 @@ find_kernel_nfs_mount_version(void) {
 	     nfs_mount_version = NFS_MOUNT_VERSION;
 	return nfs_mount_version;
 }
+static inline struct pmaplist *
+get_pmaps(struct sockaddr_in *addr)
+{
+	static struct pmaplist *phead = NULL;
+	static struct sockaddr_in *lastaddr = NULL;
+
+	/*
+	 * Make sure we are taking to the same server
+	 */
+	if (lastaddr && (addr->sin_addr.s_addr != lastaddr->sin_addr.s_addr))
+		phead = NULL;
+	
+	if (phead == NULL)
+		phead = pmap_getmaps(addr);
+
+	lastaddr = addr;
+	return phead;
+}
+#define NFS_TCP_CAP 0x01
+#define NFS_V3_CAP  0x02
+
+static unsigned short
+get_nfs_caps(struct sockaddr_in *server_addr)
+{
+	struct pmaplist *pmap;
+	unsigned short nfs_caps = 0;
+
+	if ((pmap = get_pmaps(server_addr)) == NULL)
+		return 0;
+
+	do {
+		if (pmap->pml_map.pm_prog == NFS_PROGRAM) {
+			if (pmap->pml_map.pm_prot == IPPROTO_TCP)
+				nfs_caps |= NFS_TCP_CAP;
+			if (pmap->pml_map.pm_vers == 3)
+				nfs_caps |= NFS_V3_CAP;
+			/*
+			 * Check to see if we are finished
+			 */
+			if ((nfs_caps & (NFS_TCP_CAP|NFS_V3_CAP)) == (NFS_TCP_CAP|NFS_V3_CAP))
+				break;
+		}
+	} while ((pmap = pmap->pml_next));
+	
+	return nfs_caps;
+}
 
 static struct pmap *
 get_mountport(struct sockaddr_in *server_addr,
@@ -155,7 +201,7 @@ get_mountport(struct sockaddr_in *server
 	p.pm_port = port;
 
 	server_addr->sin_port = PMAPPORT;
-	pmap = pmap_getmaps(server_addr);
+	pmap = get_pmaps(server_addr);
 
 	while (pmap) {
 		if (pmap->pml_map.pm_prog != prog)
@@ -230,6 +276,7 @@ int nfsmount(const char *spec, const cha
 	time_t t;
 	time_t prevt;
 	time_t timeout;
+	unsigned short nfs_caps;
 
 	/* The version to try is either specified or 0
 	   In case it is 0 we tell the caller what we tried */
@@ -443,6 +490,49 @@ int nfsmount(const char *spec, const cha
 			}
 		}
 	}
+
+	/* create mount deamon client */
+	/* See if the nfs host = mount host. */
+	if (mounthost) {
+		if (mounthost[0] >= '0' && mounthost[0] <= '9') {
+			mount_server_addr.sin_family = AF_INET;
+			mount_server_addr.sin_addr.s_addr = inet_addr(hostname);
+		} else {
+			if ((hp = gethostbyname(mounthost)) == NULL) {
+				fprintf(stderr, _("mount: can't get address for %s\n"),
+					mounthost);
+				goto fail;
+			} else {
+				if (hp->h_length > sizeof(struct in_addr)) {
+					fprintf(stderr,
+						_("mount: got bad hp->h_length?\n"));
+					hp->h_length = sizeof(struct in_addr);
+				}
+				mount_server_addr.sin_family = AF_INET;
+				memcpy(&mount_server_addr.sin_addr,
+				       hp->h_addr, hp->h_length);
+			}
+		}
+	}
+	/*
+	 * Set the defaults to be NFS v3 over TCP iff the
+	 * version or transport have not been explicitly
+	 * set and the server is able to support those
+	 * options.
+	 */
+	if (nfsvers == 0 || tcp == 0) {
+		if ((nfs_caps = get_nfs_caps(&mount_server_addr))) {
+			if (nfsvers == 0) {
+				if (nfs_caps & NFS_V3_CAP)
+					nfsvers = 3;
+			}
+			if (tcp == 0) {
+				if (nfs_caps & NFS_TCP_CAP)
+					tcp = 1;
+			}
+		}
+	}
+
 	proto = (tcp) ? IPPROTO_TCP : IPPROTO_UDP;
 
 	data.flags = (soft ? NFS_MOUNT_SOFT : 0)
@@ -518,29 +608,6 @@ int nfsmount(const char *spec, const cha
 		return retval;
 	}
 
-	/* create mount deamon client */
-	/* See if the nfs host = mount host. */
-	if (mounthost) {
-		if (mounthost[0] >= '0' && mounthost[0] <= '9') {
-			mount_server_addr.sin_family = AF_INET;
-			mount_server_addr.sin_addr.s_addr = inet_addr(hostname);
-		} else {
-			if ((hp = gethostbyname(mounthost)) == NULL) {
-				fprintf(stderr, _("mount: can't get address for %s\n"),
-					mounthost);
-				goto fail;
-			} else {
-				if (hp->h_length > sizeof(struct in_addr)) {
-					fprintf(stderr,
-						_("mount: got bad hp->h_length?\n"));
-					hp->h_length = sizeof(struct in_addr);
-				}
-				mount_server_addr.sin_family = AF_INET;
-				memcpy(&mount_server_addr.sin_addr,
-				       hp->h_addr, hp->h_length);
-			}
-		}
-	}
 
 	/*
 	 * The following loop implements the mount retries. On the first
@@ -675,7 +742,8 @@ int nfsmount(const char *spec, const cha
 		if (t >= timeout)
 			goto fail;
 	}
-	nfsvers = (pm_mnt->pm_vers < 2) ? 2 : pm_mnt->pm_vers;
+	if (nfsvers == 0)
+		nfsvers = (pm_mnt->pm_vers < 2) ? 2 : pm_mnt->pm_vers;
 
 	if (nfsvers == 2) {
 		if (status.nfsv2.fhs_status != 0) {


--------------020601020503030005020209--

