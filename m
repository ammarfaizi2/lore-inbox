Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVK3Cfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVK3Cfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVK3Cfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:35:48 -0500
Received: from TANG-FOUR-EIGHTY-ONE.MIT.EDU ([18.251.6.226]:18400 "EHLO
	TANG-FOUR-EIGHTY-ONE.MIT.EDU") by vger.kernel.org with ESMTP
	id S1750806AbVK3Cfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:35:47 -0500
Date: Tue, 29 Nov 2005 21:35:45 -0500
From: David Chau <ddcc@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Why can setuid programs regain root after dropping it when using
 capabilities?
Message-ID: <20051129213545.6154ce37@TANG-FOUR-EIGHTY-ONE.MIT.EDU>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While debugging some code, I found that a setuid program could regain
root after dropping root if the program used capabilities. (I tested
this on 2.6.14 and 2.6.9.) Is this the expected behavior? Here's a
short test case:

/* chown root this program, suid it, and run it as non-root */
#include <sys/types.h>
#include <sys/capability.h>
#include <unistd.h>
#include <stdio.h>
int main() {
   cap_set_proc(cap_from_text("all-eip")); /* drop all caps */
   setuid(getuid());                       /* drop root. this call succeeds */
   setuid(0);                              /* this should fail! but doesn't */
   printf("%d\n", geteuid());              /* we regained root. prints 0 */
   return 0;
}

(If we don't use capabilities at all, and take out the cap_set_proc
line, then the program behaves as expected, and doesn't allow us to
regain root.)

--David
