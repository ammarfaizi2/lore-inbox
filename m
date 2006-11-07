Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754170AbWKGJzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbWKGJzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754169AbWKGJzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:55:55 -0500
Received: from hqemgate02.nvidia.com ([216.228.112.143]:47171 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1754166AbWKGJzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:55:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C70252.D136C452"
Subject: RE: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
Date: Tue, 7 Nov 2006 17:55:11 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C8DDCF5@hkemmail01.nvidia.com>
In-Reply-To: <20061031104055.GA8898@infradead.org>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
Thread-Index: Acb82Qts6eVTNSWaR+ieCZ0wx7dLyAFeDCAQ
From: "Peer Chen" <pchen@nvidia.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <jeff@garzik.org>, <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>, "Kuan Luo" <kluo@nvidia.com>
X-OriginalArrivalTime: 07 Nov 2006 09:55:16.0976 (UTC) FILETIME=[D3F1C700:01C70252]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C70252.D136C452
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Modified and resent out the patch as attachment.
Description about the patch:
Add SGPIO support in sata_nv.c.
SGPIO (Serial General Purpose Input Output) is a sideband serial 4-wire
interface that a storage controller uses to communicate with a storage
enclosure management controller, primarily to control activity and
status LEDs that are located within drive bays or on a storage
backplane. SGPIO is defined by [SFF8485].
In this patch,we drive the LEDs to blink when read/write operation
happen on SATA drives connect the corresponding ports on MCP55 board.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The patch will be applied to kernel 2.6.19-rc4-git9.

Singed-off-by: Kuan Luo <kluo@nvidia.com>
Singed-off-by: Peer Chen <pchen@nvidia.com>


BRs
Peer Chen

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org]=20
Sent: Tuesday, October 31, 2006 6:41 PM
To: Peer Chen
Cc: jeff@garzik.org; linux-kernel@vger.kernel.org;
linux-ide@vger.kernel.org; Kuan Luo
Subject: Re: [PATCH] SCSI: Add the SGPIO support for sata_nv.c

On Tue, Oct 31, 2006 at 04:43:19PM +0800, Peer Chen wrote:
> The following SGPIO patch for sata_nv.c is based on 2.6.18 kernel.
> Signed-off by: Kuan Luo <kluo@nvidia.com>

First I'd like to say the patch subject isn't very informative.  For
a sata_nv patch it should read:

[PATCH] sata_nv: foooblah

and then the SGPIO in both the subject and description doesn't say
anything
at all, what functionality or improvement does this patch actually add.

And in general send patches against latest git or -mm tree.  I don't
know
how much the sata_nv driver changed since 2.6.18 but in general sending
patches against old kernel means they often can't be applied anymore.

> +//sgpio
> +// Sgpio defines
> +// SGPIO state defines

please use /* */ style comments.  Also these aren't exactly useful

> +#define NV_ON 1
> +#define NV_OFF 0
> +#ifndef bool
> +#define bool u8
> +#endif

please don't use your own bool types.

> +#define BF_EXTRACT(v, off, bc)	\
> +	((((u8)(v)) >> (off)) & ((1 << (bc)) - 1))
> +
> +#define BF_INS(v, ins, off, bc)				\
> +	(((v) & ~((((1 << (bc)) - 1)) << (off))) |	\
> +	(((u8)(ins)) << (off)))
> +
> +#define BF_EXTRACT_U32(v, off, bc)	\
> +	((((u32)(v)) >> (off)) & ((1 << (bc)) - 1))
> +
> +#define BF_INS_U32(v, ins, off, bc)			\
> +	(((v) & ~((((1 << (bc)) - 1)) << (off))) |	\
> +	(((u32)(ins)) << (off)))

please make such things inline functions.  Also they could have
more descriptive names.

> +union nv_sgpio_nvcr=20
> +{
> +	struct {
> +		u8	init_cnt;
> +		u8	cb_size;
> +		u8	cbver;
> +		u8	rsvd;
> +	} bit;
> +	u32	all;
> +};
> +
> +union nv_sgpio_tx=20
> +{
> +	u8	tx_port[4];
> +	u32 	all;
> +};
> +
> +struct nv_sgpio_cb=20
> +{
> +	u64			scratch_space;
> +	union nv_sgpio_nvcr	nvcr;
> +	u32			cr0;
> +	u32                     rsvd[4];
> +	union nv_sgpio_tx       tx[2];
> +};
> +
> +struct nv_sgpio_host_share
> +{
> +	spinlock_t	*plock;
> +	unsigned long   *ptstamp;
> +};
> +
> +struct nv_sgpio_host_flags
> +{
> +	u8	sgpio_enabled:1;
> +	u8	need_update:1;
> +	u8	rsvd:6;
> +};
> +=09
> +struct nv_host_sgpio
> +{
> +	struct nv_sgpio_host_flags	flags;
> +	u8				*pcsr;
> +	struct nv_sgpio_cb		*pcb;=09
> +	struct nv_sgpio_host_share	share;
> +	struct timer_list		sgpio_timer;
> +};
> +
> +struct nv_sgpio_port_flags
> +{
> +	u8	last_state:1;
> +	u8	recent_activity:1;
> +	u8	rsvd:6;
> +};
> +
> +struct nv_sgpio_led=20
> +{
> +	struct nv_sgpio_port_flags	flags;
> +	u8				force_off;
> +	u8      			last_cons_active;
> +};
> +
> +struct nv_port_sgpio
> +{
> +	struct nv_sgpio_led	activity;
> +};
> +
> +static spinlock_t	nv_sgpio_lock;

please use DEFINE_SPINLOCK to initialize the lock statically.

> +static unsigned long	nv_sgpio_tstamp;

> +static inline void nv_sgpio_set_csr(u8 csr, unsigned long pcsr)
> +{
> +	outb(csr, pcsr);
> +}
> +
> +static inline u8 nv_sgpio_get_csr(unsigned long pcsr)
> +{
> +	return inb(pcsr);
> +}

these helpers aren't useful at all, please remove them.

> +static inline u8 nv_sgpio_get_func(struct ata_host_set *host_set)
> +{
> +	u8 devfn =3D (to_pci_dev(host_set->dev))->devfn;
> +	return (PCI_FUNC(devfn));
> +}
> +
> +static inline u8 nv_sgpio_tx_host_offset(struct ata_host_set
*host_set)
> +{
> +	return (nv_sgpio_get_func(host_set)/NV_CNTRLR_SHARE_INIT);
> +}
> +
> +static inline u8 nv_sgpio_calc_tx_offset(u8 cntrlr, u8 channel)
> +{
> +	return (sizeof(union nv_sgpio_tx) - (NV_CNTRLR_SHARE_INIT *
> +		(cntrlr % NV_CNTRLR_SHARE_INIT)) - channel - 1);
> +}
> +
> +static inline u8 nv_sgpio_tx_port_offset(struct ata_port *ap)
> +{
> +	u8 cntrlr =3D nv_sgpio_get_func(ap->host_set);
> +	return (nv_sgpio_calc_tx_offset(cntrlr, ap->port_no));
> +}
> +
> +static inline bool nv_sgpio_capable(const struct pci_device_id *ent)
> +{
> +	if (ent->device =3D=3D PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2)
> +		return 1;
> +	else
> +		return 0;
> +}
>  static int nv_init_one (struct pci_dev *pdev, const struct
> pci_device_id *ent);
>  static void nv_ck804_host_stop(struct ata_host_set *host_set);
>  static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance,
> @@ -90,7 +259,10 @@
>  				      struct pt_regs *regs);
>  static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
>  static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg,
u32
> val);
> -
> +static void nv_host_stop (struct ata_host_set *host_set);
> +static int nv_port_start(struct ata_port *ap);
> +static void nv_port_stop(struct ata_port *ap);
> +static int nv_qc_issue(struct ata_queued_cmd *qc);
>  static void nv_nf2_freeze(struct ata_port *ap);
>  static void nv_nf2_thaw(struct ata_port *ap);
>  static void nv_ck804_freeze(struct ata_port *ap);
> @@ -147,6 +319,27 @@
>  	{ 0, } /* terminate list */
>  };
> =20
> +struct nv_host
> +{
> +	unsigned long		host_flags;
> +	struct nv_host_sgpio	host_sgpio;
> +};
> +
> +struct nv_port
> +{
> +	struct nv_port_sgpio	port_sgpio;
> +};
> +
> +// SGPIO function prototypes
> +static void nv_sgpio_init(struct pci_dev *pdev, struct nv_host
*phost);
> +static void nv_sgpio_reset(u8 *pcsr);
> +static void nv_sgpio_set_timer(struct timer_list *ptimer,=20
> +				unsigned int timeout_msec);
> +static void nv_sgpio_timer_handler(unsigned long ptr);
> +static void nv_sgpio_host_cleanup(struct nv_host *host);
> +static bool nv_sgpio_update_led(struct nv_sgpio_led *led, bool
> *on_off);
> +static void nv_sgpio_clear_all_leds(struct ata_port *ap);
> +static bool nv_sgpio_send_cmd(struct nv_host *host, u8 cmd);
>  static struct pci_driver nv_pci_driver =3D {
>  	.name			=3D DRV_NAME,
>  	.id_table		=3D nv_pci_tbl,
> @@ -184,7 +377,7 @@
>  	.bmdma_stop		=3D ata_bmdma_stop,
>  	.bmdma_status		=3D ata_bmdma_status,
>  	.qc_prep		=3D ata_qc_prep,
> -	.qc_issue		=3D ata_qc_issue_prot,
> +	.qc_issue		=3D nv_qc_issue,
>  	.freeze			=3D ata_bmdma_freeze,
>  	.thaw			=3D ata_bmdma_thaw,
>  	.error_handler		=3D nv_error_handler,
> @@ -194,9 +387,9 @@
>  	.irq_clear		=3D ata_bmdma_irq_clear,
>  	.scr_read		=3D nv_scr_read,
>  	.scr_write		=3D nv_scr_write,
> -	.port_start		=3D ata_port_start,
> -	.port_stop		=3D ata_port_stop,
> -	.host_stop		=3D ata_pci_host_stop,
> +	.port_start		=3D nv_port_start,
> +	.port_stop		=3D nv_port_stop,
> +	.host_stop		=3D nv_host_stop,
>  };
> =20
>  static const struct ata_port_operations nv_nf2_ops =3D {
> @@ -211,7 +404,7 @@
>  	.bmdma_stop		=3D ata_bmdma_stop,
>  	.bmdma_status		=3D ata_bmdma_status,
>  	.qc_prep		=3D ata_qc_prep,
> -	.qc_issue		=3D ata_qc_issue_prot,
> +	.qc_issue		=3D nv_qc_issue,
>  	.freeze			=3D nv_nf2_freeze,
>  	.thaw			=3D nv_nf2_thaw,
>  	.error_handler		=3D nv_error_handler,
> @@ -221,9 +414,9 @@
>  	.irq_clear		=3D ata_bmdma_irq_clear,
>  	.scr_read		=3D nv_scr_read,
>  	.scr_write		=3D nv_scr_write,
> -	.port_start		=3D ata_port_start,
> -	.port_stop		=3D ata_port_stop,
> -	.host_stop		=3D ata_pci_host_stop,
> +	.port_start		=3D nv_port_start,
> +	.port_stop		=3D nv_port_stop,
> +	.host_stop		=3D nv_host_stop,
>  };
> =20
>  static const struct ata_port_operations nv_ck804_ops =3D {
> @@ -238,7 +431,7 @@
>  	.bmdma_stop		=3D ata_bmdma_stop,
>  	.bmdma_status		=3D ata_bmdma_status,
>  	.qc_prep		=3D ata_qc_prep,
> -	.qc_issue		=3D ata_qc_issue_prot,
> +	.qc_issue		=3D nv_qc_issue,
>  	.freeze			=3D nv_ck804_freeze,
>  	.thaw			=3D nv_ck804_thaw,
>  	.error_handler		=3D nv_error_handler,
> @@ -248,8 +441,8 @@
>  	.irq_clear		=3D ata_bmdma_irq_clear,
>  	.scr_read		=3D nv_scr_read,
>  	.scr_write		=3D nv_scr_write,
> -	.port_start		=3D ata_port_start,
> -	.port_stop		=3D ata_port_stop,
> +	.port_start		=3D nv_port_start,
> +	.port_stop		=3D nv_port_stop,
>  	.host_stop		=3D nv_ck804_host_stop,
>  };
> =20
> @@ -480,10 +673,10 @@
>  	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
>  			   nv_hardreset, ata_std_postreset);
>  }
> -
>  static int nv_init_one (struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  {
>  	static int printed_version =3D 0;
> +	struct nv_host *host;
>  	struct ata_port_info *ppi;
>  	struct ata_probe_ent *probe_ent;
>  	int pci_dev_busy =3D 0;
> @@ -525,6 +718,13 @@
>  	if (!probe_ent)
>  		goto err_out_regions;
> =20
> +	host =3D kmalloc(sizeof(struct nv_host), GFP_KERNEL);
> +	if (!host)
> +		goto err_out_free_ent;
> +
> +	memset(host, 0, sizeof(struct nv_host));

Please use kzalloc().

> +static int nv_port_start(struct ata_port *ap)
> +{
> +	int stat;
> +	struct nv_port *port;
> +
> +	stat =3D ata_port_start(ap);
> +	if (stat) {
> +		return stat;
> +	}

useless braces.

> +
> +	port =3D kmalloc(sizeof(struct nv_port), GFP_KERNEL);
> +	if (!port)=20
> +		goto err_out_no_free;
> +
> +	memset(port, 0, sizeof(struct nv_port));

Please use kzalloc again.

> +	return (ata_qc_issue_prot(qc));

no need for braces around the return value.

> +static void nv_sgpio_init(struct pci_dev *pdev, struct nv_host
*phost)
> +{
> +	u16 csr_add;=20
> +	u32 cb_add, temp32;
> +	struct device *dev =3D pci_dev_to_dev(pdev);
> +	struct ata_host_set *host_set =3D dev_get_drvdata(dev);
> +	u8 pro=3D0;

missing spacezs around the =3D.

> +	if (!(pro&0x40))

Again missing spaces.  Please take another look at
Documentation/CodingStyle
for the preferred linux style.

> +		return;=09
> +	=09
> +	temp32 =3D csr_add;
> +	phost->host_sgpio.pcsr =3D (void *)temp32;
> +	phost->host_sgpio.pcb =3D phys_to_virt(cb_add);

Use of phys_to_virt is generally a bug.  What are you trying to do here?

> +
> +	if (phost->host_sgpio.pcb->nvcr.bit.init_cnt!=3D0x2 ||
> phost->host_sgpio.pcb->nvcr.bit.cbver!=3D0x0)

in addition to the whitespace damage this line is far too long,
please break it up.


<skipping the rest of the file for now until it's made a little more
=20readable>

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

------_=_NextPart_001_01C70252.D136C452
Content-Type: application/octet-stream;
	name="sgpio-patch-2.6.19-rc4-git9"
Content-Transfer-Encoding: base64
Content-Description: sgpio-patch-2.6.19-rc4-git9
Content-Disposition: attachment;
	filename="sgpio-patch-2.6.19-rc4-git9"

LS0tIGxpbnV4LTIuNi4xOS1yYzQtZ2l0OS9kcml2ZXJzL2F0YS9zYXRhX252LmMub3JpZwkyMDA2
LTExLTA2IDA4OjQ3OjQ5LjAwMDAwMDAwMCArMDgwMAorKysgbGludXgtMi42LjE5LXJjNC1naXQ5
L2RyaXZlcnMvYXRhL3NhdGFfbnYuYwkyMDA2LTExLTA3IDA4OjM2OjU0LjAwMDAwMDAwMCArMDgw
MApAQCAtODAsNiArODAsMTc2IEBACiAJTlZfTUNQX1NBVEFfQ0ZHXzIwX1NBVEFfU1BBQ0VfRU4g
PSAweDA0LAogfTsKIAorLyogc2dwaW8KKyogU2dwaW8gZGVmaW5lcworKiBTR1BJTyBzdGF0ZSBk
ZWZpbmVzCisqLworI2RlZmluZSBOVl9TR1BJT19TVEFURV9SRVNFVAkJMAorI2RlZmluZSBOVl9T
R1BJT19TVEFURV9PUEVSQVRJT05BTAkxCisjZGVmaW5lIE5WX1NHUElPX1NUQVRFX0VSUk9SCQky
CisKKy8qIFNHUElPIGNvbW1hbmQgb3Bjb2RlcyAqLworI2RlZmluZSBOVl9TR1BJT19DTURfUkVT
RVQJCTAKKyNkZWZpbmUgTlZfU0dQSU9fQ01EX1JFQURfUEFSQU1TCTEKKyNkZWZpbmUgTlZfU0dQ
SU9fQ01EX1JFQURfREFUQQkJMgorI2RlZmluZSBOVl9TR1BJT19DTURfV1JJVEVfREFUQQkJMwor
CisvKiBTR1BJTyBjb21tYW5kIHN0YXR1cyBkZWZpbmVzICovCisjZGVmaW5lIE5WX1NHUElPX0NN
RF9PSwkJCTAKKyNkZWZpbmUgTlZfU0dQSU9fQ01EX0FDVElWRQkJMQorI2RlZmluZSBOVl9TR1BJ
T19DTURfRVJSCQkyCisKKyNkZWZpbmUgTlZfU0dQSU9fVVBEQVRFX1RJQ0sJCTkwCisjZGVmaW5l
IE5WX1NHUElPX01JTl9VUERBVEVfREVMVEEJMzMKKyNkZWZpbmUgTlZfQ05UUkxSX1NIQVJFX0lO
SVQJCTIKKyNkZWZpbmUgTlZfU0dQSU9fTUFYX0FDVElWSVRZX09OCTIwCisjZGVmaW5lIE5WX1NH
UElPX01JTl9GT1JDRV9PRkYJCTUKKyNkZWZpbmUgTlZfU0dQSU9fUENJX0NTUl9PRkZTRVQJCTB4
NTgKKyNkZWZpbmUgTlZfU0dQSU9fUENJX0NCX09GRlNFVAkJMHg1QworI2RlZmluZSBOVl9TR1BJ
T19ERkxUX0NCX1NJWkUJCTI1NgorI2RlZmluZSBOVl9PTiAxCisjZGVmaW5lIE5WX09GRiAwCisK
KworCitzdGF0aWMgaW5saW5lIHU4IGJmX2V4dHJhY3QodTggdmFsdWUsIHU4IG9mZnNldCwgdTgg
Yml0X2NvdW50KQoreworCXJldHVybiAoKCgodTgpKHZhbHVlKSkgPj4gKG9mZnNldCkpICYgKCgx
IDw8IChiaXRfY291bnQpKSAtIDEpKTsKK30KKworc3RhdGljIGlubGluZSB1OCBiZl9pbnModTgg
dmFsdWUsIHU4IGlucywgdTggb2Zmc2V0LCB1OCBiaXRfY291bnQpCit7CisJcmV0dXJuIAkoKCh2
YWx1ZSkgJiB+KCgoKDEgPDwgKGJpdF9jb3VudCkpIC0gMSkpIDw8IChvZmZzZXQpKSkgfAorCQkJ
CQkJKCgodTgpKGlucykpIDw8IChvZmZzZXQpKSk7Cit9CisKK3N0YXRpYyBpbmxpbmUgdTMyIGJm
X2V4dHJhY3RfdTMyKHUzMiB2YWx1ZSwgdTggb2Zmc2V0LCB1OCBiaXRfY291bnQpCit7CisJcmV0
dXJuICgoKCh1MzIpKHZhbHVlKSkgPj4gKG9mZnNldCkpICYgKCgxIDw8IChiaXRfY291bnQpKSAt
IDEpKTsKKworfQorc3RhdGljIGlubGluZSB1MzIgYmZfaW5zX3UzMih1MzIgdmFsdWUsIHUzMiBp
bnMsIHU4IG9mZnNldCwgdTggYml0X2NvdW50KQoreworCXJldHVybiAJKCgodmFsdWUpICYgfigo
KCgxIDw8IChiaXRfY291bnQpKSAtIDEpKSA8PCAob2Zmc2V0KSkpIHwKKwkJCQkJCSgoKHUzMiko
aW5zKSkgPDwgKG9mZnNldCkpKTsKK30KKworI2RlZmluZSBHRVRfU0dQSU9fU1RBVFVTKHYpCWJm
X2V4dHJhY3QodiwgMCwgMikKKyNkZWZpbmUgR0VUX0NNRF9TVEFUVVModikJYmZfZXh0cmFjdCh2
LCAzLCAyKQorI2RlZmluZSBHRVRfQ01EKHYpCQliZl9leHRyYWN0KHYsIDUsIDMpCisjZGVmaW5l
IFNFVF9DTUQodiwgY21kKQkJYmZfaW5zKHYsIGNtZCwgNSwgMykgCisKKyNkZWZpbmUgR0VUX0VO
QUJMRSh2KQkJYmZfZXh0cmFjdCh2LCAyMywgMSkKKyNkZWZpbmUgU0VUX0VOQUJMRSh2KQkJYmZf
aW5zX3UzMih2LCAxLCAyMywgMSkKKworLyogTmVlZHMgdG8gaGF2ZSBhIHU4IGJpdC1maWVsZCBp
bnNlcnQuICovCisjZGVmaW5lIEdFVF9BQ1RJVklUWSh2KQkJYmZfZXh0cmFjdCh2LCA1LCAzKQor
I2RlZmluZSBTRVRfQUNUSVZJVFkodiwgb25fb2ZmKQliZl9pbnModiwgb25fb2ZmLCA1LCAzKQor
CisKKwordW5pb24gbnZfc2dwaW9fbnZjciAKK3sKKwlzdHJ1Y3QgeworCQl1OAlpbml0X2NudDsK
KwkJdTgJY2Jfc2l6ZTsKKwkJdTgJY2J2ZXI7CisJCXU4CXJzdmQ7CisJfSBiaXQ7CisJdTMyCWFs
bDsKK307CisKK3VuaW9uIG52X3NncGlvX3R4IAoreworCXU4CXR4X3BvcnRbNF07CisJdTMyIAlh
bGw7Cit9OworCitzdHJ1Y3QgbnZfc2dwaW9fY2IgCit7CisJdTY0CQkJc2NyYXRjaF9zcGFjZTsK
Kwl1bmlvbiBudl9zZ3Bpb19udmNyCW52Y3I7CisJdTMyCQkJY3IwOworCXUzMiAgICAgICAgICAg
ICAgICAgICAgIHJzdmRbNF07CisJdW5pb24gbnZfc2dwaW9fdHggICAgICAgdHhbMl07Cit9Owor
CitzdHJ1Y3QgbnZfc2dwaW9faG9zdF9zaGFyZQoreworCXNwaW5sb2NrX3QJKnBsb2NrOworCXVu
c2lnbmVkIGxvbmcgICAqcHRzdGFtcDsKK307CisKK3N0cnVjdCBudl9zZ3Bpb19ob3N0X2ZsYWdz
Cit7CisJdTgJc2dwaW9fZW5hYmxlZDoxOworCXU4CW5lZWRfdXBkYXRlOjE7CisJdTgJcnN2ZDo2
OworfTsKKwkKK3N0cnVjdCBudl9ob3N0X3NncGlvCit7CisJc3RydWN0IG52X3NncGlvX2hvc3Rf
ZmxhZ3MJZmxhZ3M7CisJdTgJCQkJKnBjc3I7CisJc3RydWN0IG52X3NncGlvX2NiCQkqcGNiOwkK
KwlzdHJ1Y3QgbnZfc2dwaW9faG9zdF9zaGFyZQlzaGFyZTsKKwlzdHJ1Y3QgdGltZXJfbGlzdAkJ
c2dwaW9fdGltZXI7Cit9OworCitzdHJ1Y3QgbnZfc2dwaW9fcG9ydF9mbGFncworeworCXU4CWxh
c3Rfc3RhdGU6MTsKKwl1OAlyZWNlbnRfYWN0aXZpdHk6MTsKKwl1OAlyc3ZkOjY7Cit9OworCitz
dHJ1Y3QgbnZfc2dwaW9fbGVkIAoreworCXN0cnVjdCBudl9zZ3Bpb19wb3J0X2ZsYWdzCWZsYWdz
OworCXU4CQkJCWZvcmNlX29mZjsKKwl1OCAgICAgIAkJCWxhc3RfY29uc19hY3RpdmU7Cit9Owor
CitzdHJ1Y3QgbnZfcG9ydF9zZ3BpbworeworCXN0cnVjdCBudl9zZ3Bpb19sZWQJYWN0aXZpdHk7
Cit9OworCitzdGF0aWMgREVGSU5FX1NQSU5MT0NLKG52X3NncGlvX2xvY2spOworCitzdGF0aWMg
dW5zaWduZWQgbG9uZwludl9zZ3Bpb190c3RhbXA7CisKKworc3RhdGljIGlubGluZSB1OCBudl9z
Z3Bpb19nZXRfZnVuYyhzdHJ1Y3QgYXRhX2hvc3QgKmhvc3QpCit7CisJdTggZGV2Zm4gPSAodG9f
cGNpX2Rldihob3N0LT5kZXYpKS0+ZGV2Zm47CisJcmV0dXJuIChQQ0lfRlVOQyhkZXZmbikpOwor
fQorCitzdGF0aWMgaW5saW5lIHU4IG52X3NncGlvX3R4X2hvc3Rfb2Zmc2V0KHN0cnVjdCBhdGFf
aG9zdCAqaG9zdCkKK3sKKwlyZXR1cm4gKG52X3NncGlvX2dldF9mdW5jKGhvc3QpL05WX0NOVFJM
Ul9TSEFSRV9JTklUKTsKK30KKworc3RhdGljIGlubGluZSB1OCBudl9zZ3Bpb19jYWxjX3R4X29m
ZnNldCh1OCBjbnRybHIsIHU4IGNoYW5uZWwpCit7CisJcmV0dXJuIChzaXplb2YodW5pb24gbnZf
c2dwaW9fdHgpIC0gKE5WX0NOVFJMUl9TSEFSRV9JTklUICoKKwkJKGNudHJsciAlIE5WX0NOVFJM
Ul9TSEFSRV9JTklUKSkgLSBjaGFubmVsIC0gMSk7Cit9CisKK3N0YXRpYyBpbmxpbmUgdTggbnZf
c2dwaW9fdHhfcG9ydF9vZmZzZXQoc3RydWN0IGF0YV9wb3J0ICphcCkKK3sKKwl1OCBjbnRybHIg
PSBudl9zZ3Bpb19nZXRfZnVuYyhhcC0+aG9zdCk7CisJcmV0dXJuIChudl9zZ3Bpb19jYWxjX3R4
X29mZnNldChjbnRybHIsIGFwLT5wb3J0X25vKSk7Cit9CisKK3N0YXRpYyBpbmxpbmUgdTggbnZf
c2dwaW9fY2FwYWJsZShjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqZW50KQoreworCWlmIChl
bnQtPmRldmljZSA9PSBQQ0lfREVWSUNFX0lEX05WSURJQV9ORk9SQ0VfTUNQNTVfU0FUQTIpCisJ
CXJldHVybiAxOworCWVsc2UKKwkJcmV0dXJuIDA7Cit9CiBzdGF0aWMgaW50IG52X2luaXRfb25l
IChzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCk7
CiBzdGF0aWMgdm9pZCBudl9jazgwNF9ob3N0X3N0b3Aoc3RydWN0IGF0YV9ob3N0ICpob3N0KTsK
IHN0YXRpYyBpcnFyZXR1cm5fdCBudl9nZW5lcmljX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpk
ZXZfaW5zdGFuY2UpOwpAQCAtODcsNyArMjU3LDEwIEBACiBzdGF0aWMgaXJxcmV0dXJuX3QgbnZf
Y2s4MDRfaW50ZXJydXB0KGludCBpcnEsIHZvaWQgKmRldl9pbnN0YW5jZSk7CiBzdGF0aWMgdTMy
IG52X3Njcl9yZWFkIChzdHJ1Y3QgYXRhX3BvcnQgKmFwLCB1bnNpZ25lZCBpbnQgc2NfcmVnKTsK
IHN0YXRpYyB2b2lkIG52X3Njcl93cml0ZSAoc3RydWN0IGF0YV9wb3J0ICphcCwgdW5zaWduZWQg
aW50IHNjX3JlZywgdTMyIHZhbCk7Ci0KK3N0YXRpYyB2b2lkIG52X2hvc3Rfc3RvcCAoc3RydWN0
IGF0YV9ob3N0ICpob3N0KTsKK3N0YXRpYyBpbnQgbnZfcG9ydF9zdGFydChzdHJ1Y3QgYXRhX3Bv
cnQgKmFwKTsKK3N0YXRpYyB2b2lkIG52X3BvcnRfc3RvcChzdHJ1Y3QgYXRhX3BvcnQgKmFwKTsK
K3N0YXRpYyB1bnNpZ25lZCBpbnQgbnZfcWNfaXNzdWUoc3RydWN0IGF0YV9xdWV1ZWRfY21kICpx
Yyk7CiBzdGF0aWMgdm9pZCBudl9uZjJfZnJlZXplKHN0cnVjdCBhdGFfcG9ydCAqYXApOwogc3Rh
dGljIHZvaWQgbnZfbmYyX3RoYXcoc3RydWN0IGF0YV9wb3J0ICphcCk7CiBzdGF0aWMgdm9pZCBu
dl9jazgwNF9mcmVlemUoc3RydWN0IGF0YV9wb3J0ICphcCk7CkBAIC0xMzUsNiArMzA4LDI3IEBA
CiAJeyB9IC8qIHRlcm1pbmF0ZSBsaXN0ICovCiB9OwogCitzdHJ1Y3QgbnZfaG9zdAoreworCXVu
c2lnbmVkIGxvbmcJCWhvc3RfZmxhZ3M7CisJc3RydWN0IG52X2hvc3Rfc2dwaW8JaG9zdF9zZ3Bp
bzsKK307CisKK3N0cnVjdCBudl9wb3J0Cit7CisJc3RydWN0IG52X3BvcnRfc2dwaW8JcG9ydF9z
Z3BpbzsKK307CisKKy8qIFNHUElPIGZ1bmN0aW9uIHByb3RvdHlwZXMgKi8KK3N0YXRpYyB2b2lk
IG52X3NncGlvX2luaXQoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHN0cnVjdCBudl9ob3N0ICpwaG9z
dCk7CitzdGF0aWMgdm9pZCBudl9zZ3Bpb19yZXNldCh1OCAqcGNzcik7CitzdGF0aWMgdm9pZCBu
dl9zZ3Bpb19zZXRfdGltZXIoc3RydWN0IHRpbWVyX2xpc3QgKnB0aW1lciwgCisJCQkJdW5zaWdu
ZWQgaW50IHRpbWVvdXRfbXNlYyk7CitzdGF0aWMgdm9pZCBudl9zZ3Bpb190aW1lcl9oYW5kbGVy
KHVuc2lnbmVkIGxvbmcgcHRyKTsKK3N0YXRpYyB2b2lkIG52X3NncGlvX2hvc3RfY2xlYW51cChz
dHJ1Y3QgbnZfaG9zdCAqaG9zdCk7CitzdGF0aWMgdTggbnZfc2dwaW9fdXBkYXRlX2xlZChzdHJ1
Y3QgbnZfc2dwaW9fbGVkICpsZWQsIHU4ICpvbl9vZmYpOworc3RhdGljIHZvaWQgbnZfc2dwaW9f
Y2xlYXJfYWxsX2xlZHMoc3RydWN0IGF0YV9wb3J0ICphcCk7CitzdGF0aWMgdTggbnZfc2dwaW9f
c2VuZF9jbWQoc3RydWN0IG52X2hvc3QgKmhvc3QsIHU4IGNtZCk7CiBzdGF0aWMgc3RydWN0IHBj
aV9kcml2ZXIgbnZfcGNpX2RyaXZlciA9IHsKIAkubmFtZQkJCT0gRFJWX05BTUUsCiAJLmlkX3Rh
YmxlCQk9IG52X3BjaV90YmwsCkBAIC0xNzIsNyArMzY2LDcgQEAKIAkuYm1kbWFfc3RvcAkJPSBh
dGFfYm1kbWFfc3RvcCwKIAkuYm1kbWFfc3RhdHVzCQk9IGF0YV9ibWRtYV9zdGF0dXMsCiAJLnFj
X3ByZXAJCT0gYXRhX3FjX3ByZXAsCi0JLnFjX2lzc3VlCQk9IGF0YV9xY19pc3N1ZV9wcm90LAor
CS5xY19pc3N1ZQkJPSBudl9xY19pc3N1ZSwKIAkuZnJlZXplCQkJPSBhdGFfYm1kbWFfZnJlZXpl
LAogCS50aGF3CQkJPSBhdGFfYm1kbWFfdGhhdywKIAkuZXJyb3JfaGFuZGxlcgkJPSBudl9lcnJv
cl9oYW5kbGVyLApAQCAtMTgyLDkgKzM3Niw5IEBACiAJLmlycV9jbGVhcgkJPSBhdGFfYm1kbWFf
aXJxX2NsZWFyLAogCS5zY3JfcmVhZAkJPSBudl9zY3JfcmVhZCwKIAkuc2NyX3dyaXRlCQk9IG52
X3Njcl93cml0ZSwKLQkucG9ydF9zdGFydAkJPSBhdGFfcG9ydF9zdGFydCwKLQkucG9ydF9zdG9w
CQk9IGF0YV9wb3J0X3N0b3AsCi0JLmhvc3Rfc3RvcAkJPSBhdGFfcGNpX2hvc3Rfc3RvcCwKKwku
cG9ydF9zdGFydAkJPSBudl9wb3J0X3N0YXJ0LAorCS5wb3J0X3N0b3AJCT0gbnZfcG9ydF9zdG9w
LAorCS5ob3N0X3N0b3AJCT0gbnZfaG9zdF9zdG9wLAogfTsKIAogc3RhdGljIGNvbnN0IHN0cnVj
dCBhdGFfcG9ydF9vcGVyYXRpb25zIG52X25mMl9vcHMgPSB7CkBAIC00NjUsMTAgKzY1OSwxMCBA
QAogCWF0YV9ibWRtYV9kcml2ZV9laChhcCwgYXRhX3N0ZF9wcmVyZXNldCwgYXRhX3N0ZF9zb2Z0
cmVzZXQsCiAJCQkgICBudl9oYXJkcmVzZXQsIGF0YV9zdGRfcG9zdHJlc2V0KTsKIH0KLQogc3Rh
dGljIGludCBudl9pbml0X29uZSAoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBw
Y2lfZGV2aWNlX2lkICplbnQpCiB7CiAJc3RhdGljIGludCBwcmludGVkX3ZlcnNpb24gPSAwOwor
CXN0cnVjdCBudl9ob3N0ICpob3N0OwogCXN0cnVjdCBhdGFfcG9ydF9pbmZvICpwcGlbMl07CiAJ
c3RydWN0IGF0YV9wcm9iZV9lbnQgKnByb2JlX2VudDsKIAlpbnQgcGNpX2Rldl9idXN5ID0gMDsK
QEAgLTUxMCw2ICs3MDQsMTEgQEAKIAlpZiAoIXByb2JlX2VudCkKIAkJZ290byBlcnJfb3V0X3Jl
Z2lvbnM7CiAKKwlob3N0ID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IG52X2hvc3QpLCBHRlBfS0VS
TkVMKTsKKwlpZiAoIWhvc3QpCisJCWdvdG8gZXJyX291dF9mcmVlX2VudDsKKworCXByb2JlX2Vu
dC0+cHJpdmF0ZV9kYXRhID0gaG9zdDsKIAlwcm9iZV9lbnQtPm1taW9fYmFzZSA9IHBjaV9pb21h
cChwZGV2LCA1LCAwKTsKIAlpZiAoIXByb2JlX2VudC0+bW1pb19iYXNlKSB7CiAJCXJjID0gLUVJ
TzsKQEAgLTUzNSw2ICs3MzQsOCBAQAogCXJjID0gYXRhX2RldmljZV9hZGQocHJvYmVfZW50KTsK
IAlpZiAocmMgIT0gTlZfUE9SVFMpCiAJCWdvdG8gZXJyX291dF9pb3VubWFwOworCWlmIChudl9z
Z3Bpb19jYXBhYmxlKGVudCkpCisJCW52X3NncGlvX2luaXQocGRldiwgaG9zdCk7CiAKIAlrZnJl
ZShwcm9iZV9lbnQpOwogCkBAIC01NTMsNiArNzU0LDQ1IEBACiAJcmV0dXJuIHJjOwogfQogCitz
dGF0aWMgaW50IG52X3BvcnRfc3RhcnQoc3RydWN0IGF0YV9wb3J0ICphcCkKK3sKKwlpbnQgc3Rh
dDsKKwlzdHJ1Y3QgbnZfcG9ydCAqcG9ydDsKKworCXN0YXQgPSBhdGFfcG9ydF9zdGFydChhcCk7
CisJaWYgKHN0YXQpCisJCXJldHVybiBzdGF0OworCQorCXBvcnQgPSBremFsbG9jKHNpemVvZihz
dHJ1Y3QgbnZfcG9ydCksIEdGUF9LRVJORUwpOworCWlmICghcG9ydCkgCisJCWdvdG8gZXJyX291
dF9ub19mcmVlOworCisJYXAtPnByaXZhdGVfZGF0YSA9IHBvcnQ7CisJcmV0dXJuIDA7CisKK2Vy
cl9vdXRfbm9fZnJlZToKKwlyZXR1cm4gMTsKK30KKworc3RhdGljIHZvaWQgbnZfcG9ydF9zdG9w
KHN0cnVjdCBhdGFfcG9ydCAqYXApCit7CisJbnZfc2dwaW9fY2xlYXJfYWxsX2xlZHMoYXApOwor
CisJaWYgKGFwLT5wcml2YXRlX2RhdGEpIHsKKwkJa2ZyZWUoYXAtPnByaXZhdGVfZGF0YSk7CisJ
CWFwLT5wcml2YXRlX2RhdGEgPSBOVUxMOworCX0KKwlhdGFfcG9ydF9zdG9wKGFwKTsKK30KKwor
c3RhdGljIHVuc2lnbmVkIGludCBudl9xY19pc3N1ZShzdHJ1Y3QgYXRhX3F1ZXVlZF9jbWQgKnFj
KQoreworCXN0cnVjdCBudl9wb3J0ICpwb3J0ID0gcWMtPmFwLT5wcml2YXRlX2RhdGE7CisKKwlp
ZiAocG9ydCkgCisJCXBvcnQtPnBvcnRfc2dwaW8uYWN0aXZpdHkuZmxhZ3MucmVjZW50X2FjdGl2
aXR5ID0gMTsKKwlyZXR1cm4gYXRhX3FjX2lzc3VlX3Byb3QocWMpOworfQogc3RhdGljIHZvaWQg
bnZfY2s4MDRfaG9zdF9zdG9wKHN0cnVjdCBhdGFfaG9zdCAqaG9zdCkKIHsKIAlzdHJ1Y3QgcGNp
X2RldiAqcGRldiA9IHRvX3BjaV9kZXYoaG9zdC0+ZGV2KTsKQEAgLTU2Niw2ICs4MDYsMjc3IEBA
CiAJYXRhX3BjaV9ob3N0X3N0b3AoaG9zdCk7CiB9CiAKK3N0YXRpYyB2b2lkIG52X2hvc3Rfc3Rv
cCAoc3RydWN0IGF0YV9ob3N0ICpob3N0KQoreworCXN0cnVjdCBudl9ob3N0ICpwaG9zdCA9IGhv
c3QtPnByaXZhdGVfZGF0YTsKKworCisJbnZfc2dwaW9faG9zdF9jbGVhbnVwKHBob3N0KTsKKwlr
ZnJlZShwaG9zdCk7CisJYXRhX3BjaV9ob3N0X3N0b3AoaG9zdCk7CisKK30KKworc3RhdGljIHZv
aWQgbnZfc2dwaW9faW5pdChzdHJ1Y3QgcGNpX2RldiAqcGRldiwgc3RydWN0IG52X2hvc3QgKnBo
b3N0KQoreworCXUxNiBjc3JfYWRkOyAKKwl1MzIgY2JfYWRkLCB0ZW1wMzI7CisJc3RydWN0IGRl
dmljZSAqZGV2ID0gcGNpX2Rldl90b19kZXYocGRldik7CisJc3RydWN0IGF0YV9ob3N0ICpob3N0
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7CisJdTggcHJvID0gMDsKKwkKKwlwY2lfcmVhZF9jb25m
aWdfd29yZChwZGV2LCBOVl9TR1BJT19QQ0lfQ1NSX09GRlNFVCwgJmNzcl9hZGQpOworCXBjaV9y
ZWFkX2NvbmZpZ19kd29yZChwZGV2LCBOVl9TR1BJT19QQ0lfQ0JfT0ZGU0VULCAmY2JfYWRkKTsK
KwlwY2lfcmVhZF9jb25maWdfYnl0ZShwZGV2LCAweEE0LCAmcHJvKTsKKwkKKwlpZiAoY3NyX2Fk
ZCA9PSAwIHx8IGNiX2FkZCA9PSAwKQorCQlyZXR1cm47CisJCisJaWYgKCEocHJvICYgMHg0MCkp
CisJCXJldHVybjsJCisJCQorCXRlbXAzMiA9IGNzcl9hZGQ7CisJcGhvc3QtPmhvc3Rfc2dwaW8u
cGNzciA9ICh2b2lkKikodW5zaWduZWQgbG9uZyl0ZW1wMzI7CisJcGhvc3QtPmhvc3Rfc2dwaW8u
cGNiID0gaW9yZW1hcChjYl9hZGQsIDI1Nik7CisKKwlpZiAocGhvc3QtPmhvc3Rfc2dwaW8ucGNi
LT5udmNyLmJpdC5pbml0X2NudCAhPSAweDIgfHwKKwkJCXBob3N0LT5ob3N0X3NncGlvLnBjYi0+
bnZjci5iaXQuY2J2ZXIgIT0gMHgwKQorCQlyZXR1cm47CisJCQorCWlmICh0ZW1wMzIgPD0gMHgy
MDAgfHwgdGVtcDMyID49IDB4RkZGRSApCisJCXJldHVybjsKKwkJCisJaWYgKGNiX2FkZCA8PSAw
eDgwMDAwIHx8IGNiX2FkZCA+PSAweDlGQzAwKQorCQlyZXR1cm47CisJCisJaWYgKHBob3N0LT5o
b3N0X3NncGlvLnBjYi0+c2NyYXRjaF9zcGFjZSA9PSAwKSB7CisJCXNwaW5fbG9ja19pbml0KCZu
dl9zZ3Bpb19sb2NrKTsKKwkJcGhvc3QtPmhvc3Rfc2dwaW8uc2hhcmUucGxvY2sgPSAmbnZfc2dw
aW9fbG9jazsKKwkJcGhvc3QtPmhvc3Rfc2dwaW8uc2hhcmUucHRzdGFtcCA9ICZudl9zZ3Bpb190
c3RhbXA7CisJCXBob3N0LT5ob3N0X3NncGlvLnBjYi0+c2NyYXRjaF9zcGFjZSA9IAorCQkJKHVu
c2lnbmVkIGxvbmcpJnBob3N0LT5ob3N0X3NncGlvLnNoYXJlOworCQlzcGluX2xvY2socGhvc3Qt
Pmhvc3Rfc2dwaW8uc2hhcmUucGxvY2spOworCQludl9zZ3Bpb19yZXNldChwaG9zdC0+aG9zdF9z
Z3Bpby5wY3NyKTsKKwkJcGhvc3QtPmhvc3Rfc2dwaW8ucGNiLT5jcjAgPSAKKwkJCVNFVF9FTkFC
TEUocGhvc3QtPmhvc3Rfc2dwaW8ucGNiLT5jcjApOworCisJCXNwaW5fdW5sb2NrKHBob3N0LT5o
b3N0X3NncGlvLnNoYXJlLnBsb2NrKTsKKwl9CisKKwlwaG9zdC0+aG9zdF9zZ3Bpby5zaGFyZSA9
IAorCQkqKHN0cnVjdCBudl9zZ3Bpb19ob3N0X3NoYXJlICopKHVuc2lnbmVkIGxvbmcpCisJCXBo
b3N0LT5ob3N0X3NncGlvLnBjYi0+c2NyYXRjaF9zcGFjZTsKKwlwaG9zdC0+aG9zdF9zZ3Bpby5m
bGFncy5zZ3Bpb19lbmFibGVkID0gMTsKKworCWluaXRfdGltZXIoJnBob3N0LT5ob3N0X3NncGlv
LnNncGlvX3RpbWVyKTsKKwlwaG9zdC0+aG9zdF9zZ3Bpby5zZ3Bpb190aW1lci5kYXRhID0gKHVu
c2lnbmVkIGxvbmcpaG9zdDsKKwludl9zZ3Bpb19zZXRfdGltZXIoJnBob3N0LT5ob3N0X3NncGlv
LnNncGlvX3RpbWVyLCAKKwkJCQlOVl9TR1BJT19VUERBVEVfVElDSyk7Cit9CisKK3N0YXRpYyB2
b2lkIG52X3NncGlvX3NldF90aW1lcihzdHJ1Y3QgdGltZXJfbGlzdCAqcHRpbWVyLCB1bnNpZ25l
ZCBpbnQgdGltZW91dF9tc2VjKQoreworCWlmICghcHRpbWVyKQorCQlyZXR1cm47CisJcHRpbWVy
LT5mdW5jdGlvbiA9IG52X3NncGlvX3RpbWVyX2hhbmRsZXI7CisJcHRpbWVyLT5leHBpcmVzID0g
bXNlY3NfdG9famlmZmllcyh0aW1lb3V0X21zZWMpICsgamlmZmllczsKKwlhZGRfdGltZXIocHRp
bWVyKTsKK30KKworc3RhdGljIHZvaWQgbnZfc2dwaW9fdGltZXJfaGFuZGxlcih1bnNpZ25lZCBs
b25nIGNvbnRleHQpCit7CisKKwlzdHJ1Y3QgYXRhX2hvc3QgKmhvc3QgPSAoc3RydWN0IGF0YV9o
b3N0ICopY29udGV4dDsKKwlzdHJ1Y3QgbnZfaG9zdCAqcGhvc3Q7CisJdTggY291bnQsIGhvc3Rf
b2Zmc2V0LCBwb3J0X29mZnNldDsKKwl1bmlvbiBudl9zZ3Bpb190eCB0eDsKKwl1OCBvbl9vZmY7
CisJdW5zaWduZWQgbG9uZyBtYXNrID0gMHhGRkZGOworCXN0cnVjdCBudl9wb3J0ICpwb3J0Owor
CisJaWYgKCFob3N0KQorCQlnb3RvIGVycl9vdXQ7CisJZWxzZSAKKwkJcGhvc3QgPSAoc3RydWN0
IG52X2hvc3QgKilob3N0LT5wcml2YXRlX2RhdGE7CisKKwlpZiAoIXBob3N0LT5ob3N0X3NncGlv
LmZsYWdzLnNncGlvX2VuYWJsZWQpCisJCWdvdG8gZXJyX291dDsKKworCWhvc3Rfb2Zmc2V0ID0g
bnZfc2dwaW9fdHhfaG9zdF9vZmZzZXQoaG9zdCk7CisKKwlzcGluX2xvY2socGhvc3QtPmhvc3Rf
c2dwaW8uc2hhcmUucGxvY2spOworCXR4ID0gcGhvc3QtPmhvc3Rfc2dwaW8ucGNiLT50eFtob3N0
X29mZnNldF07CisJc3Bpbl91bmxvY2socGhvc3QtPmhvc3Rfc2dwaW8uc2hhcmUucGxvY2spOwor
CisJZm9yIChjb3VudCA9IDA7IGNvdW50IDwgaG9zdC0+bl9wb3J0czsgY291bnQrKykgeworCQlz
dHJ1Y3QgYXRhX3BvcnQgKmFwOyAKKworCQlhcCA9IGhvc3QtPnBvcnRzW2NvdW50XTsKKwkKKwkJ
aWYgKCEoYXAgJiYgIShhcC0+ZmxhZ3MgJiBBVEFfRkxBR19ESVNBQkxFRCkpKQorCQkJY29udGlu
dWU7CisKKwkJcG9ydCA9IChzdHJ1Y3QgbnZfcG9ydCAqKWFwLT5wcml2YXRlX2RhdGE7CisJCWlm
ICghcG9ydCkKKwkJCWNvbnRpbnVlOyAgICAgICAgICAgIAkJCisJCXBvcnRfb2Zmc2V0ID0gbnZf
c2dwaW9fdHhfcG9ydF9vZmZzZXQoYXApOworCQlvbl9vZmYgPSBHRVRfQUNUSVZJVFkodHgudHhf
cG9ydFtwb3J0X29mZnNldF0pOworCQlpZiAobnZfc2dwaW9fdXBkYXRlX2xlZCgmcG9ydC0+cG9y
dF9zZ3Bpby5hY3Rpdml0eSwgJm9uX29mZikpIHsKKwkJCXR4LnR4X3BvcnRbcG9ydF9vZmZzZXRd
ID0gCisJCQkJU0VUX0FDVElWSVRZKHR4LnR4X3BvcnRbcG9ydF9vZmZzZXRdLCBvbl9vZmYpOwor
CQkJcGhvc3QtPmhvc3Rfc2dwaW8uZmxhZ3MubmVlZF91cGRhdGUgPSAxOworCSAgICAgICB9CisJ
fQorCisKKwlpZiAocGhvc3QtPmhvc3Rfc2dwaW8uZmxhZ3MubmVlZF91cGRhdGUpIHsKKwkJc3Bp
bl9sb2NrKHBob3N0LT5ob3N0X3NncGlvLnNoYXJlLnBsb2NrKTsgICAgCisJCWlmIChudl9zZ3Bp
b19nZXRfZnVuYyhob3N0KSAKKwkJCSUgTlZfQ05UUkxSX1NIQVJFX0lOSVQgPT0gMCkgeworCQkJ
cGhvc3QtPmhvc3Rfc2dwaW8ucGNiLT50eFtob3N0X29mZnNldF0uYWxsICY9IG1hc2s7CisJCQlt
YXNrID0gbWFzayA8PCAxNjsKKwkJCXR4LmFsbCAmPSBtYXNrOworCQl9IGVsc2UgeworCQkJdHgu
YWxsICY9IG1hc2s7CisJCQltYXNrID0gbWFzayA8PCAxNjsKKwkJCXBob3N0LT5ob3N0X3NncGlv
LnBjYi0+dHhbaG9zdF9vZmZzZXRdLmFsbCAmPSBtYXNrOworCQl9CisJCXBob3N0LT5ob3N0X3Nn
cGlvLnBjYi0+dHhbaG9zdF9vZmZzZXRdLmFsbCB8PSB0eC5hbGw7CisJCXNwaW5fdW5sb2NrKHBo
b3N0LT5ob3N0X3NncGlvLnNoYXJlLnBsb2NrKTsgICAgIAorIAorCQlpZiAobnZfc2dwaW9fc2Vu
ZF9jbWQocGhvc3QsIE5WX1NHUElPX0NNRF9XUklURV9EQVRBKSkgeyAKKwkJCXBob3N0LT5ob3N0
X3NncGlvLmZsYWdzLm5lZWRfdXBkYXRlID0gMDsKKwkJCXJldHVybjsKKwkJfQorCX0gZWxzZSB7
CisJCW52X3NncGlvX3NldF90aW1lcigmcGhvc3QtPmhvc3Rfc2dwaW8uc2dwaW9fdGltZXIsIAor
CQkJCU5WX1NHUElPX1VQREFURV9USUNLKTsKKwl9CitlcnJfb3V0OgorCXJldHVybjsKK30KKwor
c3RhdGljIHU4IG52X3NncGlvX3NlbmRfY21kKHN0cnVjdCBudl9ob3N0ICpob3N0LCB1OCBjbWQp
Cit7CisJdTggY3NyOworCXVuc2lnbmVkIGxvbmcgKnB0c3RhbXA7CisKKwlzcGluX2xvY2soaG9z
dC0+aG9zdF9zZ3Bpby5zaGFyZS5wbG9jayk7ICAgIAorCXB0c3RhbXAgPSBob3N0LT5ob3N0X3Nn
cGlvLnNoYXJlLnB0c3RhbXA7CisJaWYgKGppZmZpZXNfdG9fbXNlY3MoamlmZmllcyAtICpwdHN0
YW1wKSA+PSBOVl9TR1BJT19NSU5fVVBEQVRFX0RFTFRBKSB7CisJCWNzciA9IGluYigodW5zaWdu
ZWQgbG9uZylob3N0LT5ob3N0X3NncGlvLnBjc3IpOworCQlpZiAoKEdFVF9TR1BJT19TVEFUVVMo
Y3NyKSAhPSBOVl9TR1BJT19TVEFURV9PUEVSQVRJT05BTCkgfHwKKwkJCShHRVRfQ01EX1NUQVRV
Uyhjc3IpID09IE5WX1NHUElPX0NNRF9BQ1RJVkUpKSB7CisJCQkKKwkJfSBlbHNlIHsKKwkJCWhv
c3QtPmhvc3Rfc2dwaW8ucGNiLT5jcjAgPSAKKwkJCQlTRVRfRU5BQkxFKGhvc3QtPmhvc3Rfc2dw
aW8ucGNiLT5jcjApOworCQkJY3NyID0gMDsKKwkJCWNzciA9IFNFVF9DTUQoY3NyLCBjbWQpOwor
CQkJb3V0Yihjc3IsICh1bnNpZ25lZCBsb25nKWhvc3QtPmhvc3Rfc2dwaW8ucGNzcik7CisJCQkq
cHRzdGFtcCA9IGppZmZpZXM7CisJCX0KKwkJc3Bpbl91bmxvY2soaG9zdC0+aG9zdF9zZ3Bpby5z
aGFyZS5wbG9jayk7CisJCW52X3NncGlvX3NldF90aW1lcigmaG9zdC0+aG9zdF9zZ3Bpby5zZ3Bp
b190aW1lciwgCisJCQlOVl9TR1BJT19VUERBVEVfVElDSyk7CisJCXJldHVybiAxOworCX0gZWxz
ZSB7CisJCXNwaW5fdW5sb2NrKGhvc3QtPmhvc3Rfc2dwaW8uc2hhcmUucGxvY2spOworCQludl9z
Z3Bpb19zZXRfdGltZXIoJmhvc3QtPmhvc3Rfc2dwaW8uc2dwaW9fdGltZXIsIAorCQkJCShOVl9T
R1BJT19NSU5fVVBEQVRFX0RFTFRBIC0gCisJCQkJamlmZmllc190b19tc2VjcyhqaWZmaWVzIC0g
KnB0c3RhbXApKSk7CisJCXJldHVybiAwOworCX0KK30KKworc3RhdGljIHU4IG52X3NncGlvX3Vw
ZGF0ZV9sZWQoc3RydWN0IG52X3NncGlvX2xlZCAqbGVkLCB1OCAqb25fb2ZmKQoreworCXU4IG5l
ZWRfdXBkYXRlID0gMDsKKworCWlmIChsZWQtPmZvcmNlX29mZiA+IDApIHsKKwkJbGVkLT5mb3Jj
ZV9vZmYtLTsKKwl9IGVsc2UgaWYgKGxlZC0+ZmxhZ3MucmVjZW50X2FjdGl2aXR5IF4gbGVkLT5m
bGFncy5sYXN0X3N0YXRlKSB7CisJCSpvbl9vZmYgPSBsZWQtPmZsYWdzLnJlY2VudF9hY3Rpdml0
eTsKKwkJbGVkLT5mbGFncy5sYXN0X3N0YXRlID0gbGVkLT5mbGFncy5yZWNlbnRfYWN0aXZpdHk7
CisJCW5lZWRfdXBkYXRlID0gMTsKKwl9IGVsc2UgaWYgKChsZWQtPmZsYWdzLnJlY2VudF9hY3Rp
dml0eSAmIGxlZC0+ZmxhZ3MubGFzdF9zdGF0ZSkgJiYKKwkJKGxlZC0+bGFzdF9jb25zX2FjdGl2
ZSA+PSBOVl9TR1BJT19NQVhfQUNUSVZJVFlfT04pKSB7CisJCSpvbl9vZmYgPSBOVl9PRkY7CisJ
CWxlZC0+ZmxhZ3MubGFzdF9zdGF0ZSA9IE5WX09GRjsKKwkJbGVkLT5mb3JjZV9vZmYgPSBOVl9T
R1BJT19NSU5fRk9SQ0VfT0ZGOworCQluZWVkX3VwZGF0ZSA9IDE7CisJfQorCisJaWYgKCpvbl9v
ZmYpIAorCQlsZWQtPmxhc3RfY29uc19hY3RpdmUrKzsJCisJZWxzZQorCQlsZWQtPmxhc3RfY29u
c19hY3RpdmUgPSAwOworCisJbGVkLT5mbGFncy5yZWNlbnRfYWN0aXZpdHkgPSAwOworCXJldHVy
biBuZWVkX3VwZGF0ZTsKK30KKworc3RhdGljIHZvaWQgbnZfc2dwaW9fcmVzZXQodTggICpwY3Ny
KQoreworCXU4IGNzcjsKKworCWNzciA9IGluYigodW5zaWduZWQgbG9uZylwY3NyKTsKKwlpZiAo
R0VUX1NHUElPX1NUQVRVUyhjc3IpID09IE5WX1NHUElPX1NUQVRFX1JFU0VUKSB7CisJCWNzciA9
IDA7CisJCWNzciA9IFNFVF9DTUQoY3NyLCBOVl9TR1BJT19DTURfUkVTRVQpOworCQlvdXRiKGNz
ciwgKHVuc2lnbmVkIGxvbmcpcGNzcik7CisJfQorCWNzciA9IDA7CisJY3NyID0gU0VUX0NNRChj
c3IsIE5WX1NHUElPX0NNRF9SRUFEX1BBUkFNUyk7CisJb3V0Yihjc3IsICh1bnNpZ25lZCBsb25n
KXBjc3IpOworfQorCitzdGF0aWMgdm9pZCBudl9zZ3Bpb19ob3N0X2NsZWFudXAoc3RydWN0IG52
X2hvc3QgKmhvc3QpCit7CisJdTggY3NyOworCisJaWYgKCFob3N0KQorCQlyZXR1cm47CisKKwlp
ZiAoaG9zdC0+aG9zdF9zZ3Bpby5mbGFncy5zZ3Bpb19lbmFibGVkKSB7CisJCXNwaW5fbG9jayho
b3N0LT5ob3N0X3NncGlvLnNoYXJlLnBsb2NrKTsKKwkJaG9zdC0+aG9zdF9zZ3Bpby5wY2ItPmNy
MCA9IFNFVF9FTkFCTEUoaG9zdC0+aG9zdF9zZ3Bpby5wY2ItPmNyMCk7CisJCWNzciA9IDA7CisJ
CWNzciA9IFNFVF9DTUQoY3NyLCBOVl9TR1BJT19DTURfV1JJVEVfREFUQSk7CisJCW91dGIoY3Ny
LCAodW5zaWduZWQgbG9uZylob3N0LT5ob3N0X3NncGlvLnBjc3IpOworCQlzcGluX3VubG9jayho
b3N0LT5ob3N0X3NncGlvLnNoYXJlLnBsb2NrKTsKKworCQlpZiAodGltZXJfcGVuZGluZygmaG9z
dC0+aG9zdF9zZ3Bpby5zZ3Bpb190aW1lcikpCisJCQlkZWxfdGltZXIoJmhvc3QtPmhvc3Rfc2dw
aW8uc2dwaW9fdGltZXIpOworCQlob3N0LT5ob3N0X3NncGlvLmZsYWdzLnNncGlvX2VuYWJsZWQg
PSAwOworCQlob3N0LT5ob3N0X3NncGlvLnBjYi0+c2NyYXRjaF9zcGFjZSA9IDA7CisJfQorfQor
CitzdGF0aWMgdm9pZCBudl9zZ3Bpb19jbGVhcl9hbGxfbGVkcyhzdHJ1Y3QgYXRhX3BvcnQgKmFw
KQoreworCXN0cnVjdCBudl9wb3J0ICpwb3J0ID0gYXAtPnByaXZhdGVfZGF0YTsKKwlzdHJ1Y3Qg
bnZfaG9zdCAqaG9zdDsKKwl1OCBob3N0X29mZnNldCwgcG9ydF9vZmZzZXQ7CisKKwlpZiAoIXBv
cnQgfHwgIWFwLT5ob3N0KQorCQlyZXR1cm47CisJaWYgKCFhcC0+aG9zdC0+cHJpdmF0ZV9kYXRh
KQorCQlyZXR1cm47CisKKwlob3N0ID0gYXAtPmhvc3QtPnByaXZhdGVfZGF0YTsKKwlpZiAoIWhv
c3QtPmhvc3Rfc2dwaW8uZmxhZ3Muc2dwaW9fZW5hYmxlZCkKKwkJcmV0dXJuOworCisJaG9zdF9v
ZmZzZXQgPSBudl9zZ3Bpb190eF9ob3N0X29mZnNldChhcC0+aG9zdCk7CisJcG9ydF9vZmZzZXQg
PSBudl9zZ3Bpb190eF9wb3J0X29mZnNldChhcCk7CisKKwlzcGluX2xvY2soaG9zdC0+aG9zdF9z
Z3Bpby5zaGFyZS5wbG9jayk7CisJaG9zdC0+aG9zdF9zZ3Bpby5wY2ItPnR4W2hvc3Rfb2Zmc2V0
XS50eF9wb3J0W3BvcnRfb2Zmc2V0XSA9IDA7CisJaG9zdC0+aG9zdF9zZ3Bpby5mbGFncy5uZWVk
X3VwZGF0ZSA9IDE7CisJc3Bpbl91bmxvY2soaG9zdC0+aG9zdF9zZ3Bpby5zaGFyZS5wbG9jayk7
Cit9CisKIHN0YXRpYyBpbnQgX19pbml0IG52X2luaXQodm9pZCkKIHsKIAlyZXR1cm4gcGNpX3Jl
Z2lzdGVyX2RyaXZlcigmbnZfcGNpX2RyaXZlcik7Cg==

------_=_NextPart_001_01C70252.D136C452--
