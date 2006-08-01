Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751712AbWHARa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbWHARa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbWHARa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:30:58 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:65250 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1750966AbWHARa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:30:57 -0400
Message-ID: <44CF8FCF.6070401@candelatech.com>
Date: Tue, 01 Aug 2006 10:30:55 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: samba-technical@lists.samba.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: PATCH:  Enable binding to local IPv4 IP address for CIFS file system.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the ability to bind to a local IP address when
mounting CIFS file systems.  This allows better specification of which
interface a mount may use on a multi-homed machine, for instance.

The corresponding patch for mount.cifs has already been sent to the
samba mailing list.

Please consider this for 2.6.19.

Signed-off-by:  Ben Greear <greearb@candelatech.com>



diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 006eb33..1f34c3f 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -118,6 +118,7 @@ struct TCP_Server_Info {
  		struct sockaddr_in sockAddr;
  		struct sockaddr_in6 sockAddr6;
  	} addr;
+	u32 ip4_local_ip; /* if != 0, will bind locally to this IP */
  	wait_queue_head_t response_q;
  	wait_queue_head_t request_q; /* if more than maxmpx to srvr must block*/
  	struct list_head pending_mid_q;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index bae1479..1b4b0c1 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -94,13 +94,15 @@ struct smb_vol {
  	unsigned int rsize;
  	unsigned int wsize;
  	unsigned int sockopt;
+	u32 local_ip; /* allow binding to a local IP address if != 0 */
  	unsigned short int port;
  };

  static int ipv4_connect(struct sockaddr_in *psin_server,
  			struct socket **csocket,
  			char * netb_name,
-			char * server_netb_name);
+			char * server_netb_name,
+			u32 local_ip);
  static int ipv6_connect(struct sockaddr_in6 *psin_server,
  			struct socket **csocket);

@@ -194,7 +196,8 @@ cifs_reconnect(struct TCP_Server_Info *s
  			rc = ipv4_connect(&server->addr.sockAddr,
  					&server->ssocket,
  					server->workstation_RFC1001_name,
-					server->server_RFC1001_name);
+					  server->server_RFC1001_name,
+					  server->ip4_local_ip);
  		}
  		if(rc) {
  			cFYI(1,("reconnect error %d",rc));
@@ -983,6 +986,18 @@ cifs_parse_mount_options(char *options,
  				printk(KERN_WARNING "CIFS: domain name too long\n");
  				return 1;
  			}
+		} else if (strnicmp(data, "local_ip", 8) == 0) {
+			if (!value || !*value) {
+				printk(KERN_WARNING "CIFS: local_ip value not specified.\n");
+				return 1;	/* needs_arg; */
+			}
+			i = cifs_inet_pton(AF_INET, value, &(vol->local_ip));
+			if (i < 0) {
+				vol->local_ip = 0;
+				printk(KERN_WARNING "CIFS:  Could not parse local_ip: %s\n",
+				       value);
+				return 1;
+			}
  		} else if (strnicmp(data, "iocharset", 9) == 0) {
  			if (!value || !*value) {
  				printk(KERN_WARNING "CIFS: invalid iocharset specified\n");
@@ -1217,7 +1232,8 @@ cifs_parse_mount_options(char *options,
  static struct cifsSesInfo *
  cifs_find_tcp_session(struct in_addr * target_ip_addr,
  		struct in6_addr *target_ip6_addr,
-		 char *userName, struct TCP_Server_Info **psrvTcp)
+		      char *userName, struct TCP_Server_Info **psrvTcp,
+		      u32 local_ip)
  {
  	struct list_head *tmp;
  	struct cifsSesInfo *ses;
@@ -1227,7 +1243,11 @@ cifs_find_tcp_session(struct in_addr * t
  	list_for_each(tmp, &GlobalSMBSessionList) {
  		ses = list_entry(tmp, struct cifsSesInfo, cifsSessionList);
  		if (ses->server) {
-			if((target_ip_addr &&
+			if((target_ip_addr &&
+			    /* If binding to a local IP, do not re-use sessions bound to different
+			     * local IP addresses.
+			     */
+			    (local_ip == ses->server->ip4_local_ip) &&
  				(ses->server->addr.sockAddr.sin_addr.s_addr
  				  == target_ip_addr->s_addr)) || (target_ip6_addr
  				&& memcmp(&ses->server->addr.sockAddr6.sin6_addr,
@@ -1250,7 +1270,7 @@ cifs_find_tcp_session(struct in_addr * t
  }

  static struct cifsTconInfo *
-find_unc(__be32 new_target_ip_addr, char *uncName, char *userName)
+find_unc(__be32 new_target_ip_addr, char *uncName, char *userName, u32 local_ip)
  {
  	struct list_head *tmp;
  	struct cifsTconInfo *tcon;
@@ -1265,8 +1285,9 @@ find_unc(__be32 new_target_ip_addr, char
  				     (" old ip addr: %x == new ip %x ?",
  				      tcon->ses->server->addr.sockAddr.sin_addr.
  				      s_addr, new_target_ip_addr));
-				if (tcon->ses->server->addr.sockAddr.sin_addr.
-				    s_addr == new_target_ip_addr) {
+				if ((local_ip == tcon->ses->server->ip4_local_ip) &&
+				    (tcon->ses->server->addr.sockAddr.sin_addr.
+				     s_addr == new_target_ip_addr)) {
  	/* BB lock tcon and server and tcp session and increment use count here? */
  					/* found a match on the TCP session */
  					/* BB check if reconnection needed */
@@ -1366,7 +1387,8 @@ static void rfc1002mangle(char * target,

  static int
  ipv4_connect(struct sockaddr_in *psin_server, struct socket **csocket,
-	     char * netbios_name, char * target_name)
+	     char * netbios_name, char * target_name,
+	     u32 local_ip /* in network byte order */)
  {
  	int rc = 0;
  	int connected = 0;
@@ -1385,6 +1407,24 @@ ipv4_connect(struct sockaddr_in *psin_se
  		}
  	}

+	/* Bind to the local IP address if specified */
+	if (local_ip) {
+		struct sockaddr_in myaddr = {
+			.sin_family = AF_INET,
+		};
+		myaddr.sin_addr.s_addr = local_ip;
+		myaddr.sin_port = 0; /* any */
+		rc = (*csocket)->ops->bind(*csocket, (struct sockaddr *) &myaddr,
+					   sizeof(myaddr));
+		if (rc < 0) {
+			printk("Tried to bind to local ip: 0x%x, but failed with error: %d\n",
+			       local_ip, rc);
+		}
+		else {
+			printk("CIFS:  Successfully bound to local ip: 0x%x\n", local_ip);
+		}
+	}
+	
  	psin_server->sin_family = AF_INET;
  	if(psin_server->sin_port) { /* user overrode default port */
  		rc = (*csocket)->ops->connect(*csocket,
@@ -1664,11 +1704,12 @@ cifs_mount(struct super_block *sb, struc
  	if(address_type == AF_INET)
  		existingCifsSes = cifs_find_tcp_session(&sin_server.sin_addr,
  			NULL /* no ipv6 addr */,
-			volume_info.username, &srvTcp);
+			volume_info.username, &srvTcp,
+			volume_info.local_ip);
  	else if(address_type == AF_INET6)
  		existingCifsSes = cifs_find_tcp_session(NULL /* no ipv4 addr */,
  			&sin_server6.sin6_addr,
-			volume_info.username, &srvTcp);
+			volume_info.username, &srvTcp, 0);
  	else {
  		kfree(volume_info.UNC);
  		kfree(volume_info.password);
@@ -1686,7 +1727,8 @@ cifs_mount(struct super_block *sb, struc
  			sin_server.sin_port = 0;
  		rc = ipv4_connect(&sin_server,&csocket,
  				  volume_info.source_rfc1001_name,
-				  volume_info.target_rfc1001_name);
+				  volume_info.target_rfc1001_name,
+				  volume_info.local_ip);
  		if (rc < 0) {
  			cERROR(1,
  			       ("Error connecting to IPv4 socket. Aborting operation"));
@@ -1713,6 +1755,7 @@ cifs_mount(struct super_block *sb, struc
  			/* BB Add code for ipv6 case too */
  			srvTcp->ssocket = csocket;
  			srvTcp->protocolType = IPV4;
+			srvTcp->ip4_local_ip = volume_info.local_ip;
  			init_waitqueue_head(&srvTcp->response_q);
  			init_waitqueue_head(&srvTcp->request_q);
  			INIT_LIST_HEAD(&srvTcp->pending_mid_q);
@@ -1839,7 +1882,7 @@ cifs_mount(struct super_block *sb, struc

  		tcon =
  		    find_unc(sin_server.sin_addr.s_addr, volume_info.UNC,
-			     volume_info.username);
+			     volume_info.username, volume_info.local_ip);
  		if (tcon) {
  			cFYI(1, ("Found match on UNC path"));
  			/* we can have only one retry value for a connection

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

