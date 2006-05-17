Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWEQXZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWEQXZa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 19:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWEQXZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 19:25:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:36222 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750709AbWEQXZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 19:25:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=fWY/MJRTEXDshM8h6OqWN13Uqk1cWjBf3PbZ3rzmk6TgnBGBQo/MdyrrCpISGsD+Z2dowOsrPOco9iK1tD6LDMTs9pn8bolZMe23NiwLdi777D1/lXxQ0Nr3WwlEWX5GNmRqtfVogeK1HYuhn4CwPRuM0dn14HOyBvGp0W2OnUs=
Message-ID: <446BB0E5.50003@gmail.com>
Date: Wed, 17 May 2006 17:25:25 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Adrian Bunk <bunk@stusta.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc4-mm1 nfsroot build err, looks related to klibc
References: <44692CA1.5000903@gmail.com> <446950E3.4060601@zytor.com> <20060516101838.GK6931@stusta.de> <446A2243.6050109@zytor.com> <446ACCCF.1030406@gmail.com> <446B4BDD.9090208@zytor.com> <446B5AB0.8050703@gmail.com> <446B5BC7.7080105@zytor.com>
In-Reply-To: <446B5BC7.7080105@zytor.com>
Content-Type: multipart/mixed;
 boundary="------------030908070207070003060308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030908070207070003060308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


some of the argument processing in nfsmount/main.c is looks broken,
where hostname gets pulled from argv[optind].  I changed it to [1]
and things worked better.

tweaks and debug patch attached, presumably it explains it clearly, if 
wrongly.

heres several loops-of { add printfs, rebuild, look at output }
I did along the way:

IP-Config: eth0 guessed nameserver address 192.168.42.1
IP-Config: eth0 complete (from 192.168.42.1):
 address: 192.168.42.100   broadcast: 192.168.42.255   netmask: 
255.255.255.0
 gateway: 0.0.0.0          dns0     : 192.168.42.1     dns1   : 0.0.0.0
 rootserver: 192.168.42.1 rootpath: /nfshost/truck
eth0: state = 4
kinit: do_mounts
kinit: name_to_dev_t(/dev/nfs) = dev(0,255)
kinit: root_dev = dev(0,255)
NFS-Root: mounting 192.168.42.1:/nfshost/truck on /root with options 'none'
arg 0: NFS-Mount'
[   22.656000] Kernel panic - not syncing: Attempted to kill init!
arg 1: 192.168.4[   22.660000]  2.1:/nfshost/tru<0>Rebooting in 5 
seconds..ck'
arg 2: /root'
kinit options done: args remaining: 2
arg 0: NFS-Mount
arg 1: 192.168.42.1:/nfshost/truck
arg 2: /root
rem_name: 192.168.42.1:/nfshost/truck rem_path: /nfshost/truck
server 0 hostname 192.168.42.1
server 12aa8c0 hostname 192.168.42.1
path /nfs_root
stat: No such file or directory


the last 2 lines bothers me - since its the local path, on a 
as-yet-umounted root,
I dont know what it means to 'stat' such a path.

So I //d it, and resumed.  I got farther this time..

path /nfs_root
nfs_mount: rem_name 192.168.42.1:/nfshost/truck, hostname 192.168.42.1, 
server 12aa8c0, rem_path /nfshost/truck, path /nfs_root
connect: Network is unreachable
connect: Network is unreachable
Port for 100003/3[tcp]: 0
NFS over TCP not available from 192.168.42.1
Checking for init: /sbin/init
Checking for init: /bin/init
Checking for init: /etc/init
Checking for init: /bin/sh
kinit: init not found!


I repeated with the laptop firewall down, same result.
 netstat -tl agrees.
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address               Foreign 
Address             State
tcp        0      0 *:nfs                       
*:*                         LISTEN


the eth0 driver is builtin.

So, Im stuck for a clue.  Older kernels run fine

tia
-jimc

--------------030908070207070003060308
Content-Type: text/plain;
 name="diff.linux-2.6.17-rc4-mm1-ska.20060517.165919"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff.linux-2.6.17-rc4-mm1-ska.20060517.165919"

diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-rc4-mm1/usr/kinit/nfsmount/main.c linux-2.6.17-rc4-mm1-ska/usr/kinit/nfsmount/main.c
--- linux-2.6.17-rc4-mm1/usr/kinit/nfsmount/main.c	2006-05-17 14:57:55.000000000 -0600
+++ linux-2.6.17-rc4-mm1-ska/usr/kinit/nfsmount/main.c	2006-05-17 16:47:59.000000000 -0600
@@ -203,13 +203,19 @@ int nfsmount_main(int argc, char *argv[]
 			return 1;
 		}
 	}
+	fprintf(stderr, "%s options done: args remaining: %d\n",
+		progname, optind);
+	for (c=0; argv[c]; c++)
+		fprintf(stderr, "arg %d: %s\n", c, argv[c]);
+
+	// optind++; // remove the 'NFS-Mount'
 
 	if (optind == argc) {
 		fprintf(stderr, "%s: need a path\n", progname);
 		return 1;
 	}
-
-	hostname = rem_path = argv[optind];
+	c = 1;
+	hostname = rem_path = argv[c]; //optind];
 
 	if ((rem_name = strdup(rem_path)) == NULL) {
 		perror("strdup");
@@ -217,25 +223,30 @@ int nfsmount_main(int argc, char *argv[]
 	}
 
 	if ((rem_path = strchr(rem_path, ':')) == NULL) {
-		fprintf(stderr, "%s: need a server\n", progname);
+		fprintf(stderr, "%s: need a server address: (%s) ng\n",
+			progname, hostname);
 		return 1;
 	}
 
 	*rem_path++ = '\0';
+	fprintf(stderr, "rem_name: %s rem_path: %s\n", rem_name, rem_path);
 
 	if (*rem_path != '/') {
-		fprintf(stderr, "%s: need a path\n", progname);
+		fprintf(stderr, "%s: now need a path\n", progname);
 		return 1;
 	}
 
+	fprintf(stderr, "server %x hostname %s\n", server, hostname);
 	server = parse_addr(hostname);
+	fprintf(stderr, "server %x hostname %s\n", server, hostname);
 
 	if (optind <= argc - 2)
 		path = argv[optind + 1];
 	else
 		path = "/nfs_root";
 
-	check_path(path);
+	fprintf(stderr, "path %s\n", path);
+	//check_path(path);
 
 #if! _KLIBC_NO_MMU
 	/* Note: uClinux can't fork(), so the spoof portmapper is not
@@ -247,6 +258,10 @@ int nfsmount_main(int argc, char *argv[]
 		return 1;
 #endif
 
+	fprintf(stderr,"nfs_mount: "
+	       "rem_name %s, hostname %s, server %x, rem_path %s, path %s\n",
+	       rem_name, hostname, server, rem_path, path);
+
 	if (nfs_mount(rem_name, hostname, server, rem_path, path,
 		      &mount_data) != 0)
 		return 1;
diff -ruNp -X dontdiff -X exclude-diffs linux-2.6.17-rc4-mm1/usr/kinit/nfsroot.c linux-2.6.17-rc4-mm1-ska/usr/kinit/nfsroot.c
--- linux-2.6.17-rc4-mm1/usr/kinit/nfsroot.c	2006-05-17 14:57:55.000000000 -0600
+++ linux-2.6.17-rc4-mm1-ska/usr/kinit/nfsroot.c	2006-05-17 15:41:33.000000000 -0600
@@ -97,12 +97,15 @@ int mount_nfs_root(int argc, char *argv[
 	}
 
 	DEBUG(("NFS-Root: mounting %s on %s with options '%s'\n",
-	       argv[a - 1], mtpt, opts ? opts : "none"));
+	       nfs_argv[1], mtpt, opts ? opts : "none"));
 
 	nfs_argv[a++] = mtpt;
 	nfs_argv[a] = NULL;
 	assert(a <= NFS_ARGC);
 
+	for (ret = 0; ret<a; ret++)
+		DEBUG(("arg %d: %s'\n", ret, nfs_argv[ret]));
+
 	if ((ret = nfsmount_main(a, nfs_argv)) != 0) {
 		ret = -1;
 		goto done;

--------------030908070207070003060308--
