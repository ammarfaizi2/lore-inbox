Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbUL2Ert@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbUL2Ert (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 23:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbUL2Ert
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 23:47:49 -0500
Received: from wine.ocn.ne.jp ([220.111.47.146]:15041 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP id S261319AbUL2Erq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 23:47:46 -0500
To: linux-kernel@vger.kernel.org
Subject: Is CAP_SYS_ADMIN checked by every program !?
From: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
Message-Id: <200412291347.JEH41956.OOtStPFFNMLJVGMYS@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Wed, 29 Dec 2004 13:47:47 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

I found a strange behavior with kernel 2.6.9 and later. ( I haven't tested for 2.6.8 and earlier. )
It seems to me that every program calls capable(CAP_SYS_ADMIN),
even for programs such as cat(1) sed(1) ls(1).
My environment is Fedora Core 3.

The following is the patch for checking.

----- Start of Patch -----
*** sched.h.org Sat Dec 25 06:33:59 2004
--- sched.h     Wed Dec 29 13:00:53 2004
***************
*** 870,875 ****
--- 870,882 ----
  #else
  static inline int capable(int cap)
  {
+       if (cap == CAP_SYS_ADMIN) {
+               static pid_t last_pid = 0;
+               if (current->pid != last_pid) {
+                       printk("euid=%d uid=%d %s %s\n", current->euid, current->uid, cap_raised(current->cap_effective, CAP_SYS_ADMIN) ? "true" : "fa
lse", current->comm);
+                       last_pid = current->pid;
+               }
+       }
        if (cap_raised(current->cap_effective, cap)) {
                current->flags |= PF_SUPERPRIV;
                return 1;
----- End of Patch -----

Programs run as root always show "true", and run as non-root always show "false",
but it's will be OK.
I can't understand why every program checks for CAP_SYS_ADMIN .
With 2.4.28 and RedHat 9, no such behavior happens.

Is this normal behavior for 2.6 ?



I located .config at http://hp.vector.co.jp/authors/VA022513/tmp/config-2.6.10 .
(By the way, why not prepare ".config file keeper" like pgp.mit.edu ? I think it can save ML traffic. )



Regards.

-------
  Tetsuo Handa
