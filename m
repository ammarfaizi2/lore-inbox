Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932793AbWJGTw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbWJGTw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 15:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWJGTw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 15:52:57 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:4314 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932793AbWJGTw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 15:52:56 -0400
Subject: Re: 2.6.19-rc1 regression: airo suspend fails
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com, netdev@vger.kernel.org, pavel@suse.cz,
       linux-pm@osdl.org
In-Reply-To: <20061006184706.GR16812@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	 <871wpmoyjv.fsf@sycorax.lbl.gov>  <20061006184706.GR16812@stusta.de>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 14:52:51 -0500
Message-Id: <1160250771.24902.6.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 20:47 +0200, Adrian Bunk wrote:
> On Thu, Oct 05, 2006 at 09:31:16PM -0700, Alex Romosan wrote:

> > it breaks suspend when the airo module is loaded:
> > 
> > kernel: Stopping tasks: =================================================================================
> > kernel:  stopping tasks timed out after 20 seconds (1 tasks remaining):
> > kernel:   eth1
> > kernel: Restarting tasks...<6> Strange, eth1 not stopped
> > 
> > if i remove the airo module suspend works normally (this is on a
> > thinkpad t40).
> 
> Thanks for your report.
> 
> Let's try to figure out what broke it.

I believe it was broken by:
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=3b4c7d640376dbccfe80fc4f7b8772ecc7de28c5

I have seen this in the -mm tree, but didn't follow up at the time.  I
was able to fix it with the following patch.  I don't know if it's the
best fix, but it seems to follow the same logic as the original code.


The airo driver used to break out of while loop if there were any signals
pending.  Since it no longer checks for signals, it at least needs to check
if it needs to be frozen.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

diff -Nurp linux-2.6.19-rc1/drivers/net/wireless/airo.c linux/drivers/net/wireless/airo.c
--- linux-2.6.19-rc1/drivers/net/wireless/airo.c	2006-10-05 07:22:39.000000000 -0500
+++ linux/drivers/net/wireless/airo.c	2006-10-07 13:42:13.000000000 -0500
@@ -3090,7 +3090,8 @@ static int airo_thread(void *data) {
 						set_bit(JOB_AUTOWEP, &ai->jobs);
 						break;
 					}
-					if (!kthread_should_stop()) {
+					if (!kthread_should_stop() &&
+					    !freezing(current)) {
 						unsigned long wake_at;
 						if (!ai->expires || !ai->scan_timeout) {
 							wake_at = max(ai->expires,
@@ -3102,7 +3103,8 @@ static int airo_thread(void *data) {
 						schedule_timeout(wake_at - jiffies);
 						continue;
 					}
-				} else if (!kthread_should_stop()) {
+				} else if (!kthread_should_stop() &&
+					   !freezing(current)) {
 					schedule();
 					continue;
 				}

-- 
David Kleikamp
IBM Linux Technology Center

