Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759451AbWLDEKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759451AbWLDEKr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 23:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759452AbWLDEKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 23:10:46 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:17309 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1759451AbWLDEKq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 23:10:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [Openipmi-developer] [PATCH 11/12] IPMI: Fix BT long busy
Date: Sun, 3 Dec 2006 20:10:45 -0800
Message-ID: <FE74AC4E0A23124DA52B99F17F44159701DBC05C@PA-EXCH03.vmware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Openipmi-developer] [PATCH 11/12] IPMI: Fix BT long busy
Thread-Index: AccXIcXpkxIFtZeCQDW6zivXvpZzJwANvTBt
References: <20061202043921.GG30531@localdomain> <20061203132636.a7ac969d.akpm@osdl.org>
From: "Bela Lubkin" <blubkin@vmware.com>
To: "Andrew Morton" <akpm@osdl.org>, <minyard@acm.org>
Cc: "Rocky Craig" <rocky.craig@hp.com>,
       "OpenIPMI Developers" <openipmi-developer@lists.sourceforge.net>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Corey Minyard <minyard@acm.org> wrote:

>> +	BT_CONTROL(BT_CLR_WR_PTR);	/* always reset */

> argh.

>> #define BT_STATUS	bt->io->inputb(bt->io, 0)
>> #define BT_CONTROL(x)	bt->io->outputb(bt->io, 0, x)
>>
>> #define BMC2HOST	bt->io->inputb(bt->io, 1)
>> #define HOST2BMC(x)	bt->io->outputb(bt->io, 1, x)
>>
>> #define BT_INTMASK_R	bt->io->inputb(bt->io, 2)
>> #define BT_INTMASK_W(x)	bt->io->outputb(bt->io, 2, x)

> Please don't write macros which require that the caller have a particular
> local variable of a particular name.
>
> In fact, please don't write macros.
>
> All the above would be perfectly nice as
>
> static inline void bt_control(struct si_sm_data *bt, int val)
> {
> 	bt->io->outputb(bt->io, val);
> }

Well, needs an input and an output function to route through `inputb' /
`outputb'.  But the important values here, which _should_ be macros, are the
register offsets:

#define BT_STATUS_REG  0   /* Read-only */
#define BT_CONTROL_REG 0   /* Write-only */
#define BT_DATA_REG    1   /* Read/write */
#define BT_INTMASK_REG 2   /* Read/write */

static inline int bt_control_read(struct si_sm_data *bt, int reg)
{
	return bt->io->inputb(bt->io, reg);
}

static inline void bt_control_write(struct si_sm_data *bt, int reg, int data)
{
	bt->io->outputb(bt->io, reg, data);
}

bt_control_read(bt, BT_STATUS_REG);            /* was BT_STATUS()    */
bt_control_write(bt, BT_CONTROL_REG, data);    /* was BT_CONTROL()   */
bt_control_read(bt, BT_DATA_REG);              /* was BMC2HOST()     */
bt_control_write(bt, BT_DATA_REG, data);       /* was HOST2BMC()     */
bt_control_read(bt, BT_INTMASK_REG);           /* was BT_INTMASK_R() */
bt_control_write(bt, BT_INTMASK_REG, data);    /* was BT_INTMASK_W() */

...

But the old macro names are more readable at the calling point.  What about
making them into inlines (which call the generic _read / _write())?  Maybe
with lowercased versions of the original macro names.

>Bela<
