Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755217AbWKRRat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbWKRRat (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 12:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbWKRRat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 12:30:49 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:31429 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1755212AbWKRRar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 12:30:47 -0500
Date: Sat, 18 Nov 2006 18:25:25 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Divy Le Ray <divy@chelsio.com>" <divy@chelsio.com>
cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/10] cxgb3 - main header files
In-Reply-To: <20061117202320.25878.26769.stgit@colfax2.asicdesigners.com>
Message-ID: <Pine.LNX.4.61.0611181757010.5252@yvahk01.tjqt.qr>
References: <20061117202320.25878.26769.stgit@colfax2.asicdesigners.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 17 2006 12:23, Divy Le Ray <divy@chelsio.com> wrote:
>Subject: [PATCH 1/10] cxgb3 - main header files

(For all files)

Some suggestions:

 *  change the typedefs to struct, this includes:
        adapter_t -> struct adapter



 *  function prototypes and function headers (e.g. t3_get_cong_cntl_tab)
    are listed as

        void t3_get_cong_cntl_tab(adapter_t *adap,
                         unsigned short incr[NMTUS][NCCTRL_WIN]);

    which could be shortened to

        void t3_get_cong_cntl_tab(adapter_t *adap,
                         unsigned short incr[][]);

    functions where there is only one level of [], e.g.

        void t3_load_mtus(adapter_t *adap, unsigned short mtus[NMTUS],
                  unsigned short alpha[NCCTRL_WIN],
                  unsigned short beta[NCCTRL_WIN], unsigned short mtu_cap);

    could become

        void t3_load_mtus(adapter_t *adap, unsigned short *mtus,
                  unsigned short *alpha,
                  unsigned short *beta, unsigned short mtu_cap);

    depending on your taste.



 *  get rid of superfluous from-void/to-void casts, such as:

        cxgb3_main.c:754:  struct adapter *adapter =
                           (struct adapter *)dev->priv;

    in some places, the 'U' suffix for literal numbers is not required,
    such as:

        cxgb3_main.c:292:   unsigned int nq1 = max((unsigned
                            int)adap->port[1].nqsets, 1U);

        sge.c:2359:  qs->rspq.holdoff_tmr = max(p->coalesce_usecs * 10, 1U);



 *  const run 1: const'ify structs that do not change or
    are not changed, such as

        cxgb3_main.c:924:static char stats_strings[][ETH_GSTRING_LEN] = {

        t3_hw.c:220:static struct mdio_ops mi1_mdio_ops = {
        t3_hw.c:271:static struct mdio_ops mi1_mdio_ext_ops = {

        t3_hw.c:1130:   static struct intr_info pcix1_intr_info[] = {
        t3_hw.c:1166:   static struct intr_info pcie_intr_info[] = {

    (these are just the small picture)



 *  const run 2: const'ify locals that do not change, such as

        cxgb3_offload.c:63:     struct adapter *adapter = tdev2adap(tdev);



 *  const run 3: const'ify function arguments that do not change, e.g.

       static inline int offload_activated(struct t3cdev *tdev)


Note that the listed lines do not cover all source lines - cxgb3
is quite some code.

Running it through sparse gives 'context imbalance' (whatever that is - i just
tried sparse).


	-`J'
-- 
