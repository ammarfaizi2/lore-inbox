Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWAWUZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWAWUZQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWAWUZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:25:15 -0500
Received: from fmr20.intel.com ([134.134.136.19]:51372 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932466AbWAWUZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:25:13 -0500
Date: Mon, 23 Jan 2006 12:23:26 -0800 (PST)
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
X-X-Sender: jbrandeb@lindenhurst-2.jf.intel.com
To: kus Kusche Klaus <kus@keba.com>
cc: Lee Revell <rlrevell@joe-job.com>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       "Ronciak, John" <john.ronciak@intel.com>,
       "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
       netdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: RE: My vote against eepro* removal
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323329@MAILIT.keba.co.at>
Message-ID: <Pine.LNX.4.64.0601231202530.3847@lindenhurst-2.jf.intel.com>
References: <AAD6DA242BC63C488511C611BD51F367323329@MAILIT.keba.co.at>
ReplyTo: "Jesse Brandeburg" <jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-2038021199-1704791452-1138047576=:3847"
Content-ID: <Pine.LNX.4.64.0601231220450.4263@lindenhurst-2.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2038021199-1704791452-1138047576=:3847
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0601231220451.4263@lindenhurst-2.jf.intel.com>

On Mon, 23 Jan 2006, kus Kusche Klaus wrote:
> From: John Ronciak
> > Can we try a couple of things? 1) just comment out all the check for
> > link code in the e100 driver and give that a try and 2) just comment
> > out the update stats call and see if that works.  These seem to be the
> > differences and we need to know which one is causing the problem.
> 
> First of all, I am still unable to get any traces of this in the
> latency tracer. Moreover, as I told before, removing parts of the
> watchdog usually made my eth0 nonfunctional (which is bad - this
> is an embedded system with ssh access).
> 
> Hence, I explicitely instrumented the watchdog function with tsc.
> Output of the timings is done by a background thread, so the
> timings should not increase the runtime of the watchdog.
> 
> Here are my results:
> 
> If the watchdog doesn't get interrupted, preempted, or whatever,
> it spends 340 us in its body:
> * 303 us in the mii code
> *  36 us in the following code up to e100_adjust_adaptive_ifs
> *   1 us in the remaining code (I think my chip doesn't need any
> of those chip-specific fixups)
> 
> The 303 us in the mii code are divided in the following way:
> * 101 us in mii_ethtool_gset
> * 135 us in the whole if
> *  67 us in mii_check_link
> 
> This is with the udelay(2) instead of udelay(20) hack applied.
> With udelay(20), the mii times are 128 + 170 + 85 us,
> i.e. 383 us instead of 303 us, or >= 420 us for the whole watchdog.
> 
> As the RTC runs with 8192 Hz during my tests, the watchdog is hit
> by 2-3 interrupts, which adds another 75 - 110 us to its total
> execution time, i.e. the time it blocks other rtprio 1 threads.

Thank you very much for that detailed analysis!  okay, so calls to mii.c 
take too long, but those depend on mmio_read in e100 to do the work, so 
this patch attempts to minimize the latency.

This patch is against linus-2.6.git, I compile and ssh/ping tested it. 
Would you be willing to send your instrumentation patches?  I could then 
test any fixes easier.

e100: attempt a shorter delay for mdio reads

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Simply reorder our write/read sequence for mdio reads to minimize latency
as well as delay a shorter interval for each loop.
---

  drivers/net/e100.c |   12 +++++++-----
  1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/e100.c b/drivers/net/e100.c
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -891,23 +891,25 @@ static u16 mdio_ctrl(struct nic *nic, u3
  	 * procedure it should be done under lock.
  	 */
  	spin_lock_irqsave(&nic->mdio_lock, flags);
-	for (i = 100; i; --i) {
+	for (i = 1000; i; --i) {
  		if (readl(&nic->csr->mdi_ctrl) & mdi_ready)
  			break;
-		udelay(20);
+		udelay(2);
  	}
  	if (unlikely(!i)) {
-		printk("e100.mdio_ctrl(%s) won't go Ready\n",
+		DPRINTK(PROBE, ERR, "e100.mdio_ctrl(%s) won't go Ready\n",
  			nic->netdev->name );
  		spin_unlock_irqrestore(&nic->mdio_lock, flags);
  		return 0;		/* No way to indicate timeout error */
  	}
  	writel((reg << 16) | (addr << 21) | dir | data, &nic->csr->mdi_ctrl);

-	for (i = 0; i < 100; i++) {
-		udelay(20);
+	/* to avoid latency, read to flush the write, then delay, and only
+	 * delay 2us per loop, manual says read should complete in < 64us */
+	for (i = 0; i < 1000; i++) {
  		if ((data_out = readl(&nic->csr->mdi_ctrl)) & mdi_ready)
  			break;
+		udelay(2);
  	}
  	spin_unlock_irqrestore(&nic->mdio_lock, flags);
  	DPRINTK(HW, DEBUG,
---2038021199-1704791452-1138047576=:3847--
