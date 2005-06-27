Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVF0Frm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVF0Frm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 01:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVF0Frm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 01:47:42 -0400
Received: from mail-1.netbauds.net ([62.232.161.102]:58784 "EHLO
	mail-1.netbauds.net") by vger.kernel.org with ESMTP id S261832AbVF0FrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:47:25 -0400
Message-ID: <42BF92D4.3040609@netbauds.net>
Date: Mon, 27 Jun 2005 06:47:00 +0100
From: "Darryl L. Miles" <darryl@netbauds.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
References: <42BDFEC2.3030004@netbauds.net> <20050625234611.118b391d.akpm@osdl.org> <42BE7E38.9070703@netbauds.net> <42BE98C5.1070102@web.de> <20050626141106.GA12223@shuttle.vanvergehaald.nl>
In-Reply-To: <20050626141106.GA12223@shuttle.vanvergehaald.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are we sure we are not talking about two different problems here.

I'm using RedHat and mkinitrd, in the initrd image there is already a 
skeleton /dev tree that contains my real-root device.  udev also exists 
in the initrd image.  I don't think any /dev device magic was necessary 
for me too mount root.

It is not clear Chris which tools you are using on initrd, standard 
Gentoo methods or a home brew setup ?  What shell is calling modprobe ?  
Can you confirm at what point you are seeing modprobe exit ?

* Immediatly (before device driver has detected hardware and reported / 
registered its findings).  This is the symptom I was seeing, but the 
cause was incorrect shell handling. 
* After detection but before device node creation.
* After device node creation.


FYI - This looks like the snippet from nash.c

@@ -403,7 +450,7 @@
 int otherCommand(char * bin, char * cmd, char * end, int doFork) {
     char ** args;
     char ** nextArg;
-    int pid;
+    int pid, wpid;
     int status;
     char fullPath[255];
     static const char * sysPath = PATH;
@@ -479,10 +526,20 @@

        close(stdoutFd);

-       wait4(-1, &status, 0, NULL);
-       if (!WIFEXITED(status) || WEXITSTATUS(status)) {
-           printf("ERROR: %s exited abnormally!\n", args[0]);
-           return 1;
+       for (;;) {
+            wpid = wait4(-1, &status, 0, NULL);
+            if (wpid == -1) {
+                 printf("ERROR: Failed to wait for process %d\n", wpid);
+            }
+
+            if (wpid != pid)
+                 continue;
+
+            if (!WIFEXITED(status) || WEXITSTATUS(status)) {
+                 printf("ERROR: %s exited abnormally with value %d ! (pid %d)\n", args[0], WEXITSTATUS(status), pid);
+                 return 1;
+            }
+            break;
        }
     }


-- 
Darryl L. Miles


