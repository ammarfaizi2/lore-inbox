Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268911AbUIHHrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268911AbUIHHrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 03:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268907AbUIHHrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 03:47:23 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:3598 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268911AbUIHHq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 03:46:27 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Greg KH <greg@kroah.com>
Subject: [PATCH] udev: udevd shall inform us abot trouble
Date: Wed, 8 Sep 2004 10:18:43 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TJrPBSvkhRMZR3v"
Message-Id: <200409081018.43626.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_TJrPBSvkhRMZR3v
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Greg,

I found out why udev didn't work for me.
At first I compiled it with wrong install path ($DESTDIR).
On subsequent recompiles with corrected DESTDIR binaries
were still compiled with old DESTDIR hardcoded into them.

I think this Make rule is generating a udev_version.h:

# Rules on how to create the generated header files
udev_version.h:
        @echo \#define UDEV_VERSION             \"$(VERSION)\" > $@
        @echo \#define UDEV_ROOT                \"$(udevdir)/\" >> $@
        @echo \#define UDEV_DB                  \"$(udevdir)/.udev.tdb\" >> $@
        @echo \#define UDEV_CONFIG_DIR          \"$(configdir)\" >> $@
        @echo \#define UDEV_CONFIG_FILE         \"$(configdir)/udev.conf\" >> $@
        @echo \#define UDEV_RULES_FILE          \"$(configdir)/rules.d\" >> $@
        @echo \#define UDEV_PERMISSION_FILE     \"$(configdir)/permissions.d\" >> $@
        @echo \#define UDEV_LOG_DEFAULT         \"yes\" >> $@
        @echo \#define UDEV_BIN                 \"$(DESTDIR)$(sbindir)/udev\" >> $@
        @echo \#define UDEVD_BIN                \"$(DESTDIR)$(sbindir)/udevd\" >> $@

which is not re-created even if DESTDIR has changed.

As a result, udevd was trying to exec udev with wrong path.

I built udev with:

USE_LOG = true
DEBUG = false

but udevd does not log anything under such setting (all
udevd messages are coded as debug messages).

This patch improves situation by changing some dbg()'s
into info()'s.

I run tested this change. udevd will report failure into
syslog now.

Please apply.
--
vda

--Boundary-00=_TJrPBSvkhRMZR3v
Content-Type: text/x-diff;
  charset="koi8-r";
  name="udevd.c.logging.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="udevd.c.logging.patch"

--- udevd.c.orig	Fri Jul  9 20:59:09 2004
+++ udevd.c	Thu Sep  2 09:46:43 2004
@@ -92,7 +92,7 @@ static struct hotplug_msg *msg_create(vo
 
 	new_msg = malloc(sizeof(struct hotplug_msg));
 	if (new_msg == NULL)
-		dbg("error malloc");
+		info("error malloc");
 	return new_msg;
 }
 
@@ -146,11 +146,11 @@ static void udev_run(struct hotplug_msg 
 	case 0:
 		/* child */
 		execle(udev_bin, "udev", msg->subsystem, NULL, env);
-		dbg("exec of child failed");
+		info("exec of child failed");
 		exit(1);
 		break;
 	case -1:
-		dbg("fork of child failed");
+		info("fork of child failed");
 		run_queue_delete(msg);
 		/* note: we never managed to run, so we had no impact on 
 		 * running_with_devpath(), so don't bother setting run_exec_q
@@ -255,7 +255,7 @@ static void handle_msg(int sock)
 
 	msg = msg_create();
 	if (msg == NULL) {
-		dbg("unable to store message");
+		info("unable to store message");
 		return;
 	}
 
@@ -271,24 +271,24 @@ static void handle_msg(int sock)
 	retval = recvmsg(sock, &smsg, 0);
 	if (retval <  0) {
 		if (errno != EINTR)
-			dbg("unable to receive message");
+			info("unable to receive message");
 		return;
 	}
 	cmsg = CMSG_FIRSTHDR(&smsg);
 	cred = (struct ucred *) CMSG_DATA(cmsg);
 
 	if (cmsg == NULL || cmsg->cmsg_type != SCM_CREDENTIALS) {
-		dbg("no sender credentials received, message ignored");
+		info("no sender credentials received, message ignored");
 		goto skip;
 	}
 
 	if (cred->uid != 0) {
-		dbg("sender uid=%i, message ignored", cred->uid);
+		info("sender uid=%i, message ignored", cred->uid);
 		goto skip;
 	}
 
 	if (strncmp(msg->magic, UDEV_MAGIC, sizeof(UDEV_MAGIC)) != 0 ) {
-		dbg("message magic '%s' doesn't match, ignore it", msg->magic);
+		info("message magic '%s' doesn't match, ignore it", msg->magic);
 		goto skip;
 	}
 
@@ -326,7 +326,7 @@ __attribute__((regparm(0))) static void 
 			goto do_write;
 			break;
 		default:
-			dbg("unhandled signal %d", signum);
+			info("unhandled signal %d", signum);
 			return;
 	}
 	
@@ -337,7 +337,7 @@ do_write:
 	if (!sig_flag) {
 		rc = write(pipefds[1],&signum,sizeof(signum));
 		if (rc < 0)
-			dbg("unable to write to pipe");
+			info("unable to write to pipe");
 		else
 			sig_flag = 1;
 	}
@@ -404,26 +404,26 @@ int main(int argc, char *argv[])
 	dbg("version %s", UDEV_VERSION);
 
 	if (getuid() != 0) {
-		dbg("need to be root, exit");
+		info("need to be root, exit");
 		exit(1);
 	}
 
 	/* setup signal handler pipe */
 	retval = pipe(pipefds);
 	if (retval < 0) {
-		dbg("error getting pipes: %s", strerror(errno));
+		info("error getting pipes: %s", strerror(errno));
 		exit(1);
 	}
 
 	retval = fcntl(pipefds[0], F_SETFL, O_NONBLOCK);
-		if (retval < 0) {
-		dbg("error fcntl on read pipe: %s", strerror(errno));
+	if (retval < 0) {
+		info("error fcntl on read pipe: %s", strerror(errno));
 		exit(1);
 	}
 
 	retval = fcntl(pipefds[1], F_SETFL, O_NONBLOCK);
 	if (retval < 0) {
-		dbg("error fcntl on write pipe: %s", strerror(errno));
+		info("error fcntl on write pipe: %s", strerror(errno));
 		exit(1);
 	}
 
@@ -444,14 +444,14 @@ int main(int argc, char *argv[])
 
 	ssock = socket(AF_LOCAL, SOCK_DGRAM, 0);
 	if (ssock == -1) {
-		dbg("error getting socket, exit");
+		info("error getting socket, exit");
 		exit(1);
 	}
 
 	/* the bind takes care of ensuring only one copy running */
 	retval = bind(ssock, (struct sockaddr *) &saddr, addrlen);
 	if (retval < 0) {
-		dbg("bind failed, exit");
+		info("bind failed, exit");
 		goto exit;
 	}
 
@@ -475,7 +475,7 @@ int main(int argc, char *argv[])
 
 		if (retval < 0) {
 			if (errno != EINTR)
-				dbg("error in select: %s", strerror(errno));
+				info("error in select: %s", strerror(errno));
 			continue;
 		}
 

--Boundary-00=_TJrPBSvkhRMZR3v--

