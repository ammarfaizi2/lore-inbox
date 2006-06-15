Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWFODTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWFODTa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 23:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWFODTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 23:19:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:51901 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750838AbWFODTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 23:19:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KyBN0XNXbjRD9lg40O0DoRpQHONCIzENsbaxnXGlGh+H/67eAPTNt29znByfno37FpZJOpCcbpsoFS98z83vEYuP316lmF8hcYvCnTV/BBPQHkU7t3lq+l8nY8zlt9SryIsE7lhbbU7VnkplE+3cGG83+cCs4Hmd8RgoT65uLsk=
Message-ID: <bda6d13a0606142019m439c8eavca9afd955930d324@mail.gmail.com>
Date: Wed, 14 Jun 2006 20:19:28 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: patch for "bizarre read bug" in klibc dash
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had forked ash awhile back, patched up a few things to behave the
way I wanted them.
While I was at it, I fixed the "echo X | read X ; echo $X" bug that
echoed a blank line.
I tried awhile ago to raise who was responsible for the code and got nowhere.

I suppose you think the above code is a bizarre corner case. It is
not. I use very
complex shell expressions (think loops and subshells) in pipes, with
read in the end to
get the variable I was looking for. The work-around is particularly ugly.

I was quite surprised that this bug never got squashed in dash. So, I
backported it.

Well, here's the patch.

--- usr/dash/eval.c.orig        2006-06-14 19:48:47.000000000 -0700
+++ usr/dash/eval.c     2006-06-14 20:07:58.000000000 -0700
@@ -539,7 +539,17 @@
                                sh_error("Pipe call failed");
                        }
                }
-               if (forkshell(jp, lp->n, n->npipe.backgnd) == 0) {
+               if (!lp->next) {
+                       extern void tempredir0(int prevfd);
+                       /* Fix for "bizarre read bug" */
+                       if (prevfd > 0) {
+                               tempredir0(prevfd);
+                               close(prevfd);
+                       }
+                       evaltree(lp->n, 0);
+                       if (prevfd > 0)
+                               popredir(0);
+               } else if (forkshell(jp, lp->n, n->npipe.backgnd) == 0) {
                        INTON;
                        if (pip[1] >= 0) {
                                close(pip[0]);
--- usr/dash/redir.c.orig       2006-06-14 19:59:21.000000000 -0700
+++ usr/dash/redir.c    2006-06-14 20:03:38.000000000 -0700
@@ -310,6 +310,21 @@
 }


+void tempredir0(int fd)
+{
+       struct redirtab *sv = redirlist;
+       int i;
+       sv = ckmalloc(sizeof (struct redirtab));
+       for (i = 0 ; i < 10 ; i++)
+               sv->renamed[i] = EMPTY;
+       sv->next = redirlist;
+       redirlist = sv;
+       INTOFF;
+       sv->renamed[0] = copyfd(0, 10);
+       close(0);
+       copyfd(fd, 0);
+       INTON;
+}

 /*
  * Undo the effects of the last redirection.
