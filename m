Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUFSOfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUFSOfy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 10:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUFSOfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 10:35:54 -0400
Received: from mail.gmx.de ([213.165.64.20]:15289 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263540AbUFSOfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 10:35:47 -0400
X-Authenticated: #21910825
Message-ID: <40D44F1D.6090701@gmx.net>
Date: Sat, 19 Jun 2004 16:35:09 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Francois Romieu <romieu@fr.zoreil.com>, Brian Lazara <blazara@nvidia.com>,
       Christoph Hellwig <hch@infradead.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew de Quincey <adq@lidskialf.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new device support for forcedeth.c second try
References: <40D43DC3.9000909@gmx.net> <20040619155551.A1517@electric-eye.fr.zoreil.com> <200406191615.48903.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200406191615.48903.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 19 of June 2004 15:55, Francois Romieu wrote:
> 
>>Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net> :
>>[...]
>>
>>
>>>+static int phy_reset(struct net_device *dev)
>>>+{
>>>+	struct fe_priv *np = get_nvpriv(dev);
>>>+	u32 miicontrol;
>>>+	u32 microseconds = 0;
>>>+	u32 milliseconds = 0;
>>>+
>>>+	miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
>>>+	miicontrol |= BMCR_RESET;
>>>+	if (mii_rw(dev, np->phyaddr, MII_BMCR, miicontrol)) {
>>>+		return -1;
>>>+	}
>>>+
>>>+	//wait for 500ms
>>>+	mdelay(500);
>>>+
>>>+	//must wait till reset is deasserted
>>>+	while (miicontrol & BMCR_RESET) {
>>>+		udelay(NV_MIIBUSY_DELAY);
>>>+		miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
>>>+		microseconds++;
>>>+		if (microseconds == 20) {
>>>+			microseconds = 0;
>>>+			milliseconds++;
>>>+		}
>>>+		if (milliseconds > 50)
>>>+			return -1;
>>>+	}
>>>+	return 0;
>>>+}
>>
>>Afaiks this function is not called from a spinlocked nor is it
>>time-critical. You should make it use schedule_timeout().

Thanks for highlighting the above code. I saw it and wanted to fix it, but
then I got sidetracked and forgot.

> msleep()

Bartlomiej, could you prepare a patch to move the msleep() function from
drivers/scsi/libata-core.c to include/linux/delay.h ? This is going to
benefit users besides libata.


New version:

static int phy_reset(struct net_device *dev)
{
        struct fe_priv *np = get_nvpriv(dev);
        u32 miicontrol;
        unsigned int tries = 0;

        miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
        miicontrol |= BMCR_RESET;
        if (mii_rw(dev, np->phyaddr, MII_BMCR, miicontrol)) {
                return -1;
        }

        //wait for 500ms
        msleep(500);

        //must wait till reset is deasserted
        while (miicontrol & BMCR_RESET) {
                udelay(NV_MIIBUSY_DELAY);
                miicontrol = mii_rw(dev, np->phyaddr, MII_BMCR, MII_READ);
                /* FIXME: 1000 tries seem excessive */
                if (tries++ > 1000)
                        return -1;
        }
        return 0;
}


Better?

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

