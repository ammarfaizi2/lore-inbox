Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTENWQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbTENWQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:16:18 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:18575 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S263011AbTENWQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:16:02 -0400
Message-Id: <5.1.1.5.2.20030514152509.022fd1e8@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 14 May 2003 15:28:49 -0700
To: linux-kernel@vger.kernel.org
From: Ken Ashcraft <kash@stanford.edu>
Subject: [CHECKER] Passing wrong size to memcpy/memset
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[This is a repost since I posted incorrectly the first time and I didn't 
get any response.]

Hi,

I'm with the Stanford Metacompilation research group and I wrote a checker
that looks for places where people use 'sizeof(ptr)' instead of
'sizeof(*ptr)' as the length argument to memcpy/memset.  The problem is that
they are trying to copy an entire structure but end up only copying the
first 4 bytes.  I ran it on the 2.5.69 kernel and came up with 22 errors.
These should be really easy to confirm and fix even though the bugs
themselves could be really nasty.

I'm going to extend the checker in the next couple of days to account for
other functions like memcpy and memset that take length arguments.  In
addition, I'll modify it to watch for the incorrect use of sizeof as a loop
bound.  If anyone has any other ideas, I'd appreciate hearing them.

As always, confirmation of these reports is appreciated.

Thanks!
Ken Ashcraft

#  Total   = 22
# BUGs | File Name
6 | /crypto/tcrypt.c
4 | /drivers/megaraid.c
2 | /crypto/deflate.c
2 | /net/nr_route.c
1 | /drivers/ohci1394.c
1 | /pci/emufx.c
1 | /crypto/md5.c
1 | /hardware/maintidi.c
1 | /fs/md5.c
1 | /net/sdla_chdlc.c
1 | /crypto/md4.c
1 | /net/airo.c

---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/crypto/deflate.c:111:deflate_decomp_in
it: ERROR:SIZEOF:111:111:passing wrong size to 'memset'
                             deflate_gfp());
if (!stream->workspace ) {
  ret = -ENOMEM;
  goto out;
}

Error --->
memset(stream->workspace, 0, sizeof(stream->workspace));
ret = zlib_inflateInit2(stream, -DEFLATE_DEF_WINBITS);
if (ret != Z_OK) {
  ret = -EINVAL;
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/crypto/deflate.c:84:deflate_comp_init:
ERROR:SIZEOF:84:84:passing wrong size to 'memset'
                               PAGE_KERNEL);
if (!stream->workspace ) {
  ret = -ENOMEM;
  goto out;
}

Error --->
memset(stream->workspace, 0, sizeof(stream->workspace));
ret = zlib_deflateInit2(stream, DEFLATE_DEF_LEVEL, Z_DEFLATED,
                         -DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL,
                         Z_DEFAULT_STRATEGY);
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/crypto/md4.c:218:md4_final:
ERROR:SIZEOF:218:218:passing wrong size to 'memset'
le32_to_cpu_array(mctx->block, (sizeof(mctx->block) -
                   sizeof(u64)) / sizeof(u32));
md4_transform(mctx->hash, mctx->block);
cpu_to_le32_array(mctx->hash, sizeof(mctx->hash) / sizeof(u32));
memcpy(out, mctx->hash, sizeof(mctx->hash));

Error --->
memset(mctx, 0, sizeof(mctx));
}

static struct crypto_alg alg = {
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/crypto/md5.c:213:md5_final:
ERROR:SIZEOF:213:213:passing wrong size to 'memset'
le32_to_cpu_array(mctx->block, (sizeof(mctx->block) -
                   sizeof(u64)) / sizeof(u32));
md5_transform(mctx->hash, mctx->block);
cpu_to_le32_array(mctx->hash, sizeof(mctx->hash) / sizeof(u32));
memcpy(out, mctx->hash, sizeof(mctx->hash));

Error --->
memset(mctx, 0, sizeof(mctx));
}

static struct crypto_alg alg = {
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/crypto/tcrypt.c:1030:test_des:
ERROR:SIZEOF:1030:1030:passing wrong size to 'memset'
  printk("setkey() failed flags=%x\n", tfm->crt_flags);
  goto out;
}

/* setup the dummy buffer first */

Error --->
memset(xbuf, 0, sizeof (xbuf));

xbuf[IDX1] = des_tv[i].plaintext[0];
xbuf[IDX2] = des_tv[i].plaintext[1];
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/crypto/tcrypt.c:116:test_md5:
ERROR:SIZEOF:116:116:passing wrong size to 'memset'
}

printk("\ntesting md5 across pages\n");

/* setup the dummy buffer first */

Error --->
memset(xbuf, 0, sizeof (xbuf));
memcpy(&xbuf[IDX1], "abcdefghijklm", 13);
memcpy(&xbuf[IDX2], "nopqrstuvwxyz", 13);

---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/crypto/tcrypt.c:191:test_hmac_md5:
ERROR:SIZEOF:191:191:passing wrong size to 'memset'
         "pass");
}

printk("\ntesting hmac_md5 across pages\n");


Error --->
memset(xbuf, 0, sizeof (xbuf));

memcpy(&xbuf[IDX1], "what do ya want ", 16);
memcpy(&xbuf[IDX2], "for nothing?", 12);
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/crypto/tcrypt.c:270:test_hmac_sha1:
ERROR:SIZEOF:270:270:passing wrong size to 'memset'
}

printk("\ntesting hmac_sha1 across pages\n");

/* setup the dummy buffer first */

Error --->
memset(xbuf, 0, sizeof (xbuf));

memcpy(&xbuf[IDX1], "what do ya want ", 16);
memcpy(&xbuf[IDX2], "for nothing?", 12);
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/crypto/tcrypt.c:453:test_sha1:
ERROR:SIZEOF:453:453:passing wrong size to 'memset'
}

printk("\ntesting sha1 across pages\n");

/* setup the dummy buffer first */

Error --->
memset(xbuf, 0, sizeof (xbuf));
memcpy(&xbuf[IDX1], "abcdbcdecdefdefgefghfghighij", 28);
memcpy(&xbuf[IDX2], "hijkijkljklmklmnlmnomnopnopq", 28);

---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/crypto/tcrypt.c:528:test_sha256:
ERROR:SIZEOF:528:528:passing wrong size to 'memset'
}

printk("\ntesting sha256 across pages\n");

/* setup the dummy buffer first */

Error --->
memset(xbuf, 0, sizeof (xbuf));
memcpy(&xbuf[IDX1], "abcdbcdecdefdefgefghfghighij", 28);
memcpy(&xbuf[IDX2], "hijkijkljklmklmnlmnomnopnopq", 28);

---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/drivers/ieee1394/ohci1394.c:3168:ohci_
init_config_rom: ERROR:SIZEOF:3168:3168:passing wrong size to 'memset'
static void ohci_init_config_rom(struct ti_ohci *ohci)
{
struct config_rom_ptr cr;

memset(&cr, 0, sizeof(cr));

Error --->
memset(ohci->csr_config_rom_cpu, 0, sizeof (ohci->csr_config_rom_cpu));

cr.data = ohci->csr_config_rom_cpu;

---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/drivers/isdn/hardware/eicon/maintidi.c
:119:DivaSTraceLibraryCreateInstance: ERROR:SIZEOF:119:119:passing wrong
size to 'memset'
if (!pLib) {
  return (0);
}

  pmem += sizeof(*pLib);

Error --->
memset (pLib, 0x00, sizeof(pLib));

pLib->Adapter  = Adapter;

---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/drivers/net/wan/sdla_chdlc.c:1072:disa
ble_comm: ERROR:SIZEOF:1072:1072:passing wrong size to 'memset'
     card->devname,WAN_TTY_MAJOR);
  }
  card->tty=NULL;
  tty_card_map[card->tty_minor]=NULL;
  state = &rs_table[card->tty_minor];

Error --->
  memset(state,0,sizeof(state));
}
return;
}
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/drivers/net/wireless/airo.c:4841:airo_
get_range: ERROR:SIZEOF:4841:4841:passing wrong size to 'memset'
int  k;

readCapabilityRid(local, &cap_rid);

dwrq->length = sizeof(struct iw_range);

Error --->
memset(range, 0, sizeof(range));
range->min_nwid = 0x0000;
range->max_nwid = 0x0000;
range->num_channels = 14;
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/drivers/scsi/megaraid.c:4667:mega_is_b
ios_enabled: ERROR:SIZEOF:4667:4667:passing wrong size to 'memset'
mbox_t *mbox;
int ret;

mbox = (mbox_t *)raw_mbox;


Error --->
memset(mbox, 0, sizeof(mbox));

memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);

---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/drivers/scsi/megaraid.c:4700:mega_enum
_raid_scsi: ERROR:SIZEOF:4700:4700:passing wrong size to 'memset'
mbox_t *mbox;
int i;

mbox = (mbox_t *)raw_mbox;


Error --->
memset(mbox, 0, sizeof(mbox));

/*
  * issue command to find out what channels are raid/scsi
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/drivers/scsi/megaraid.c:4821:mega_supp
ort_random_del: ERROR:SIZEOF:4821:4821:passing wrong size to 'memset'
mbox_t *mbox;
int rval;

mbox = (mbox_t *)raw_mbox;


Error --->
memset(mbox, 0, sizeof(mbox));

/*
  * issue command
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/drivers/scsi/megaraid.c:4850:mega_supp
ort_ext_cdb: ERROR:SIZEOF:4850:4850:passing wrong size to 'memset'
mbox_t *mbox;
int rval;

mbox = (mbox_t *)raw_mbox;


Error --->
memset(mbox, 0, sizeof (mbox));
/*
  * issue command to find out if controller supports extended CDBs.
  */
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/fs/cifs/md5.c:151:MD5Final:
ERROR:SIZEOF:151:151:passing wrong size to 'memset'
((__u32 *) ctx->in)[15] = ctx->bits[1];

MD5Transform(ctx->buf, (__u32 *) ctx->in);
byteReverse((unsigned char *) ctx->buf, 4);
memmove(digest, ctx->buf, 16);

Error --->
memset(ctx, 0, sizeof (ctx)); /* In case it's sensitive */
}

/* The four core functions - F1 is optimized somewhat */
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/net/netrom/nr_route.c:113:nr_add_node:
ERROR:SIZEOF:113:113:passing wrong size to 'memcpy'
  if (ax25_digi != NULL && ax25_digi->ndigi > 0) {
   if ((nr_neigh->digipeat = kmalloc(sizeof(*ax25_digi), GFP_KERNEL)) ==
NULL) {
    kfree(nr_neigh);
    return -ENOMEM;
   }

Error --->
   memcpy(nr_neigh->digipeat, ax25_digi, sizeof(ax25_digi));
  }

  spin_lock_bh(&nr_neigh_lock);
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/net/netrom/nr_route.c:390:nr_add_neigh
: ERROR:SIZEOF:390:390:passing wrong size to 'memcpy'
if (ax25_digi != NULL && ax25_digi->ndigi > 0) {
  if ((nr_neigh->digipeat = kmalloc(sizeof(*ax25_digi), GFP_KERNEL)) ==
NULL) {
   kfree(nr_neigh);
   return -ENOMEM;
  }

Error --->
  memcpy(nr_neigh->digipeat, ax25_digi, sizeof(ax25_digi));
}

spin_lock_bh(&nr_neigh_lock);
---------------------------------------------------------
[BUG]
/dryer/engler/kash/linux/linux-2.5.69/sound/pci/emu10k1/emufx.c:2209:snd_emu
10k1_fx8010_info: ERROR:SIZEOF:2209:2209:passing wrong size to 'memset'
{
char **fxbus, **extin, **extout;
unsigned short fxbus_mask, extin_mask, extout_mask;
int res;


Error --->
memset(info, 0, sizeof(info));
info->card = emu->card_type;
info->internal_tram_size = emu->fx8010.itram_size;
info->external_tram_size = emu->fx8010.etram_size;



