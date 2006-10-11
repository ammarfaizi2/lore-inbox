Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWJKS6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWJKS6g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWJKS6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:58:36 -0400
Received: from mail.corp.idt.net ([169.132.25.53]:41234 "EHLO
	mail.corp.idt.net") by vger.kernel.org with ESMTP id S932126AbWJKS6e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:58:34 -0400
Message-ID: <452D3ED9.509@hq.idt.net>
Date: Wed, 11 Oct 2006 14:58:33 -0400
From: Serge Aleynikov <serge@hq.idt.net>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@redhat.com>
Subject: non-critical security bug fix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To Maintainers of the linux/security/commoncap.c:

Patch description:
==================
This bug-fix ensures that if a process with root access sets 
keep_capabilities flag, current capabilities get preserved when the 
process switches from root to another effective user.  It looks like 
this was intended from the way capabilities are documented, but the 
current->keep_capabilities flag is not being checked.

Regards,

Serge

----------------------------[ Begin patch ]---------------------------

--- linux/security/commoncap.c.orig  2005-10-29 16:00:58.656572231 -0400
+++ linux/security/commoncap.c       2005-10-29 16:04:45.093411424 -0400
@@ -217,6 +217,10 @@
   * Keeping uid 0 is not an option because uid 0 owns too many vital
   * files..
   * Thanks to Olaf Kirch and Peter Benie for spotting this.
+ *
+ * Serge Aleynikov <serge@hq.idt.net> IDT Corp, Oct 2005
+ * Control the case (old_euid==0 && current->euid!=0) via
+ * current->keep_capabilities as well.
   */
  static inline void cap_emulate_setxuid (int old_ruid, int old_euid,
  					int old_suid)
@@ -227,7 +231,8 @@
  		cap_clear (current->cap_permitted);
  		cap_clear (current->cap_effective);
  	}
-	if (old_euid == 0 && current->euid != 0) {
+	if (old_euid == 0 && current->euid != 0 &&
+           !current->keep_capabilities) {
  		cap_clear (current->cap_effective);
  	}
  	if (old_euid != 0 && current->euid == 0) {

----------------------------[ End patch ]---------------------------



----------------------------[ Begin test ]--------------------------
Change the EFFECTIVE_UID value, compile and run the following as root.
This test tries to set the capability cap_net_raw, then switch from root
to an effective user, and open a raw socket being not a root.

#include <sys/socket.h>
#include <sys/types.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <linux/if_ether.h>
#include <netinet/in.h>
#include <unistd.h>
#include <sys/capability.h>
#include <sys/prctl.h>

#define EFFECTIVE_UID 501

int main()
{
	int s1, s2, rc;
	cap_t   caps;
	char    cmd [1024];

	if  (prctl (PR_SET_KEEPCAPS, 1, 0, 0, 0) < 0)
	    printf ("\nCould not SET_KEEPCAPS\n");
	printf ("Keeping the Capabilities: %d\n",
		prctl (PR_GET_KEEPCAPS, 0,0,0,0));

	printf ("\nReal UID=%d, Real GID=%d, Eff UID=%d, Eff GID=%d\n",
			getuid(), getgid(), geteuid(), getegid());

	caps =  cap_get_proc ();
	printf ("\nInitial Capabilities: %s\n",
		cap_to_text (caps, NULL));

	sprintf (cmd, "cap_setuid,cap_setgid,cap_net_raw=eip");
	printf  ("\nSetting the Capabilities %s\n",  cmd);
	rc   =  cap_set_proc (cap_from_text     (cmd));
	if (rc != 0)
	   printf ("Failed to set the Capabilities: %s\n",
		strerror(errno));

	caps =  cap_get_proc ();
	printf ("\nPrivileged Capabilities: %s\n",
		cap_to_text(caps, NULL));

	setegid (EFFECTIVE_UID);
	seteuid (EFFECTIVE_UID);

	printf ("\nReal UID=%d, Real GID=%d, Eff UID=%d, Eff GID=%d\n",
			getuid(), getgid(), geteuid(), getegid());

	caps =  cap_get_proc ();
	printf ("\nUnPrivileged Capabilities: %s\n",
		cap_to_text(caps, NULL));

	s1 = socket (PF_INET, SOCK_RAW, IPPROTO_RAW);
	if (s1 < 0)
		printf ("PF_INET error: %s\n", strerror (errno));

	s2 = socket (PF_PACKET, SOCK_RAW,  htonl(ETH_P_IP));
	if (s2 < 0)
		printf ("PF_INET error: %s\n", strerror (errno));

	return 0;
}
----------------------------[ End test ]----------------------------

Regards,

Serge

-- 
Serge Aleynikov
Routing R&D, IDT Telecom
Tel: +1 (973) 438-3436
Fax: +1 (973) 438-1464
