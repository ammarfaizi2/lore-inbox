Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVAaEdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVAaEdk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 23:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVAaEdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 23:33:40 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:44541 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261913AbVAaEdg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 23:33:36 -0500
Message-ID: <41FDB2D3.5CBD6F7D@gte.net>
Date: Sun, 30 Jan 2005 20:23:47 -0800
From: Bukie Mabayoje <bukiemab@gte.net>
X-Mailer: Mozilla 4.78 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: sfeldma@pobox.com
CC: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
       Michael Gernoth <simigern@stud.uni-erlangen.de>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.4.29, e100 and a WOL packet causes keventd going mad
References: <20050130171849.GA3354@hardeman.nu> <1107143255.18167.428.camel@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [66.199.68.159] at Sun, 30 Jan 2005 22:08:48 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Scott Feldman wrote:

> On Sun, 2005-01-30 at 09:18, David Härdeman wrote:
> > I experience the same problems as reported by Michael Gernoth when
> > sending a WOL-packet to computer with a e100 NIC which is already
> > powered on.
>
> I didn't look at the 2.4 case, but for 2.6, it seems e100 was enabling
> PME wakeup during probe.  PME shouldn't be enabled while the system is
> up.  I suspect the assertion of PME while the system is up is what's
> causing problems.  This patch moves PME wakeup enabling to either
> suspend or shutdown.
>
> David, would you give this patch a try?  Make sure the system still
> wakes from a magic packet if suspended or shut down, and doesn't cause
> kacpid to go crazy if system is running.  If it helps for 2.6, perhaps
> someone can look into 2.4 to see if there is something similar going on

This issue was reported on 2.4.

>
> there.
>
> -scott
>
> --- linux-2.6.11-rc2/drivers/net/e100.c.orig    2005-01-30 19:13:56.850497376 -0800
> +++ linux-2.6.11-rc2/drivers/net/e100.c 2005-01-30 19:26:41.154305536 -0800
> @@ -1868,7 +1868,6 @@ static int e100_set_wol(struct net_devic
>         else
>                 nic->flags &= ~wol_magic;
>
> -       pci_enable_wake(nic->pdev, 0, nic->flags & (wol_magic | e100_asf(nic)));
>         e100_exec_cb(nic, NULL, e100_configure);
>
>         return 0;
> @@ -2262,8 +2261,6 @@ static int __devinit e100_probe(struct p
>            (nic->eeprom[eeprom_id] & eeprom_id_wol))
>                 nic->flags |= wol_magic;
>
> -       pci_enable_wake(pdev, 0, nic->flags & (wol_magic | e100_asf(nic)));
> -
>         strcpy(netdev->name, "eth%d");
>         if((err = register_netdev(netdev))) {
>                 DPRINTK(PROBE, ERR, "Cannot register net device, aborting.\n");
> @@ -2344,6 +2341,15 @@ static int e100_resume(struct pci_dev *p
>  }
>  #endif
>
> +static void e100_shutdown(struct device *dev)
> +{
> +       struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +       struct net_device *netdev = pci_get_drvdata(pdev);
> +       struct nic *nic = netdev_priv(netdev);
> +
> +       pci_enable_wake(pdev, 0, nic->flags & (wol_magic | e100_asf(nic)));
> +}
> +
>  static struct pci_driver e100_driver = {
>         .name =         DRV_NAME,
>         .id_table =     e100_id_table,
> @@ -2353,6 +2359,9 @@ static struct pci_driver e100_driver = {
>         .suspend =      e100_suspend,
>         .resume =       e100_resume,
>  #endif
> +       .driver = {
> +               .shutdown = e100_shutdown,
> +       }
>  };
>
>  static int __init e100_init_module(void)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
