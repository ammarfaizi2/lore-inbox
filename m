Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbTEOAZq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbTEOAZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:25:46 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:59066 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263206AbTEOAZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:25:38 -0400
Date: Wed, 14 May 2003 17:33:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: Ken Ashcraft <kash@stanford.edu>
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@intercode.com.au>
Subject: Re: [CHECKER] Passing wrong size to memcpy/memset
Message-Id: <20030514173351.32c3a4c8.akpm@digeo.com>
In-Reply-To: <5.1.1.5.2.20030514152509.022fd1e8@localhost>
References: <5.1.1.5.2.20030514152509.022fd1e8@localhost>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 00:38:22.0022 (UTC) FILETIME=[49A26E60:01C31A7A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Ashcraft <kash@stanford.edu> wrote:
>
> I'm with the Stanford Metacompilation research group and I wrote a checker
> that looks for places where people use 'sizeof(ptr)' instead of
> 'sizeof(*ptr)' as the length argument to memcpy/memset. 

Well they all look like genuine bugs.  It could be that some code is just
performing overly-paranoid memsets.

I shall submit the below lot unless squeaked at.


 25-akpm/crypto/deflate.c                       |    4 ++--
 25-akpm/crypto/md4.c                           |    2 +-
 25-akpm/crypto/md5.c                           |    2 +-
 25-akpm/crypto/tcrypt.c                        |   12 ++++++------
 25-akpm/drivers/ieee1394/ohci1394.c            |    2 +-
 25-akpm/drivers/isdn/hardware/eicon/maintidi.c |    2 +-
 25-akpm/drivers/net/wan/sdla_chdlc.c           |    2 +-
 25-akpm/drivers/net/wireless/airo.c            |    2 +-
 25-akpm/drivers/scsi/megaraid.c                |    8 ++++----
 25-akpm/fs/cifs/md5.c                          |    2 +-
 25-akpm/net/netrom/nr_route.c                  |    5 +++--
 25-akpm/sound/pci/emu10k1/emufx.c              |    2 +-
 12 files changed, 23 insertions(+), 22 deletions(-)

diff -puN crypto/deflate.c~stanford-memcy-size-fixes crypto/deflate.c
--- 25/crypto/deflate.c~stanford-memcy-size-fixes	Wed May 14 17:31:09 2003
+++ 25-akpm/crypto/deflate.c	Wed May 14 17:31:09 2003
@@ -81,7 +81,7 @@ static int deflate_comp_init(struct defl
 		ret = -ENOMEM;
 		goto out;
 	}
-	memset(stream->workspace, 0, sizeof(stream->workspace));
+	memset(stream->workspace, 0, sizeof(*stream->workspace));
 	ret = zlib_deflateInit2(stream, DEFLATE_DEF_LEVEL, Z_DEFLATED,
 	                        -DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL,
 	                        Z_DEFAULT_STRATEGY);
@@ -108,7 +108,7 @@ static int deflate_decomp_init(struct de
 		ret = -ENOMEM;
 		goto out;
 	}
-	memset(stream->workspace, 0, sizeof(stream->workspace));
+	memset(stream->workspace, 0, sizeof(*stream->workspace));
 	ret = zlib_inflateInit2(stream, -DEFLATE_DEF_WINBITS);
 	if (ret != Z_OK) {
 		ret = -EINVAL;
diff -puN crypto/md4.c~stanford-memcy-size-fixes crypto/md4.c
--- 25/crypto/md4.c~stanford-memcy-size-fixes	Wed May 14 17:31:09 2003
+++ 25-akpm/crypto/md4.c	Wed May 14 17:31:09 2003
@@ -215,7 +215,7 @@ static void md4_final(void *ctx, u8 *out
 	md4_transform(mctx->hash, mctx->block);
 	cpu_to_le32_array(mctx->hash, sizeof(mctx->hash) / sizeof(u32));
 	memcpy(out, mctx->hash, sizeof(mctx->hash));
-	memset(mctx, 0, sizeof(mctx));
+	memset(mctx, 0, sizeof(*mctx));
 }
 
 static struct crypto_alg alg = {
diff -puN crypto/md5.c~stanford-memcy-size-fixes crypto/md5.c
--- 25/crypto/md5.c~stanford-memcy-size-fixes	Wed May 14 17:31:09 2003
+++ 25-akpm/crypto/md5.c	Wed May 14 17:31:09 2003
@@ -210,7 +210,7 @@ static void md5_final(void *ctx, u8 *out
 	md5_transform(mctx->hash, mctx->block);
 	cpu_to_le32_array(mctx->hash, sizeof(mctx->hash) / sizeof(u32));
 	memcpy(out, mctx->hash, sizeof(mctx->hash));
-	memset(mctx, 0, sizeof(mctx));
+	memset(mctx, 0, sizeof(*mctx));
 }
 
 static struct crypto_alg alg = {
diff -puN crypto/tcrypt.c~stanford-memcy-size-fixes crypto/tcrypt.c
--- 25/crypto/tcrypt.c~stanford-memcy-size-fixes	Wed May 14 17:31:09 2003
+++ 25-akpm/crypto/tcrypt.c	Wed May 14 17:31:09 2003
@@ -113,7 +113,7 @@ test_md5(void)
 	printk("\ntesting md5 across pages\n");
 
 	/* setup the dummy buffer first */
-	memset(xbuf, 0, sizeof (xbuf));
+	memset(xbuf, 0, sizeof(*xbuf));
 	memcpy(&xbuf[IDX1], "abcdefghijklm", 13);
 	memcpy(&xbuf[IDX2], "nopqrstuvwxyz", 13);
 
@@ -188,7 +188,7 @@ test_hmac_md5(void)
 
 	printk("\ntesting hmac_md5 across pages\n");
 
-	memset(xbuf, 0, sizeof (xbuf));
+	memset(xbuf, 0, sizeof(*xbuf));
 
 	memcpy(&xbuf[IDX1], "what do ya want ", 16);
 	memcpy(&xbuf[IDX2], "for nothing?", 12);
@@ -267,7 +267,7 @@ test_hmac_sha1(void)
 	printk("\ntesting hmac_sha1 across pages\n");
 
 	/* setup the dummy buffer first */
-	memset(xbuf, 0, sizeof (xbuf));
+	memset(xbuf, 0, sizeof(*xbuf));
 
 	memcpy(&xbuf[IDX1], "what do ya want ", 16);
 	memcpy(&xbuf[IDX2], "for nothing?", 12);
@@ -450,7 +450,7 @@ test_sha1(void)
 	printk("\ntesting sha1 across pages\n");
 
 	/* setup the dummy buffer first */
-	memset(xbuf, 0, sizeof (xbuf));
+	memset(xbuf, 0, sizeof(*xbuf));
 	memcpy(&xbuf[IDX1], "abcdbcdecdefdefgefghfghighij", 28);
 	memcpy(&xbuf[IDX2], "hijkijkljklmklmnlmnomnopnopq", 28);
 
@@ -525,7 +525,7 @@ test_sha256(void)
 	printk("\ntesting sha256 across pages\n");
 
 	/* setup the dummy buffer first */
-	memset(xbuf, 0, sizeof (xbuf));
+	memset(xbuf, 0, sizeof(*xbuf));
 	memcpy(&xbuf[IDX1], "abcdbcdecdefdefgefghfghighij", 28);
 	memcpy(&xbuf[IDX2], "hijkijkljklmklmnlmnomnopnopq", 28);
 
@@ -1027,7 +1027,7 @@ test_des(void)
 	}
 
 	/* setup the dummy buffer first */
-	memset(xbuf, 0, sizeof (xbuf));
+	memset(xbuf, 0, sizeof(*xbuf));
 
 	xbuf[IDX1] = des_tv[i].plaintext[0];
 	xbuf[IDX2] = des_tv[i].plaintext[1];
diff -puN drivers/ieee1394/ohci1394.c~stanford-memcy-size-fixes drivers/ieee1394/ohci1394.c
--- 25/drivers/ieee1394/ohci1394.c~stanford-memcy-size-fixes	Wed May 14 17:31:09 2003
+++ 25-akpm/drivers/ieee1394/ohci1394.c	Wed May 14 17:31:09 2003
@@ -3165,7 +3165,7 @@ static void ohci_init_config_rom(struct 
 	struct config_rom_ptr cr;
 
 	memset(&cr, 0, sizeof(cr));
-	memset(ohci->csr_config_rom_cpu, 0, sizeof (ohci->csr_config_rom_cpu));
+	memset(ohci->csr_config_rom_cpu, 0, sizeof(*ohci->csr_config_rom_cpu));
 
 	cr.data = ohci->csr_config_rom_cpu;
 
diff -puN drivers/isdn/hardware/eicon/maintidi.c~stanford-memcy-size-fixes drivers/isdn/hardware/eicon/maintidi.c
--- 25/drivers/isdn/hardware/eicon/maintidi.c~stanford-memcy-size-fixes	Wed May 14 17:31:09 2003
+++ 25-akpm/drivers/isdn/hardware/eicon/maintidi.c	Wed May 14 17:31:09 2003
@@ -116,7 +116,7 @@ diva_strace_library_interface_t* DivaSTr
 	}
 
   pmem += sizeof(*pLib);
-	memset (pLib, 0x00, sizeof(pLib));
+	memset(pLib, 0x00, sizeof(*pLib));
 
 	pLib->Adapter  = Adapter;
 
diff -puN drivers/net/wan/sdla_chdlc.c~stanford-memcy-size-fixes drivers/net/wan/sdla_chdlc.c
--- 25/drivers/net/wan/sdla_chdlc.c~stanford-memcy-size-fixes	Wed May 14 17:31:09 2003
+++ 25-akpm/drivers/net/wan/sdla_chdlc.c	Wed May 14 17:31:09 2003
@@ -1069,7 +1069,7 @@ static void disable_comm (sdla_t *card)
 		card->tty=NULL;
 		tty_card_map[card->tty_minor]=NULL;
 		state = &rs_table[card->tty_minor];
-		memset(state,0,sizeof(state));
+		memset(state, 0, sizeof(*state));
 	}
 	return;
 }
diff -puN drivers/net/wireless/airo.c~stanford-memcy-size-fixes drivers/net/wireless/airo.c
--- 25/drivers/net/wireless/airo.c~stanford-memcy-size-fixes	Wed May 14 17:31:09 2003
+++ 25-akpm/drivers/net/wireless/airo.c	Wed May 14 17:31:09 2003
@@ -4845,7 +4845,7 @@ static int airo_get_range(struct net_dev
 	readCapabilityRid(local, &cap_rid);
 
 	dwrq->length = sizeof(struct iw_range);
-	memset(range, 0, sizeof(range));
+	memset(range, 0, sizeof(*range));
 	range->min_nwid = 0x0000;
 	range->max_nwid = 0x0000;
 	range->num_channels = 14;
diff -puN drivers/scsi/megaraid.c~stanford-memcy-size-fixes drivers/scsi/megaraid.c
--- 25/drivers/scsi/megaraid.c~stanford-memcy-size-fixes	Wed May 14 17:31:09 2003
+++ 25-akpm/drivers/scsi/megaraid.c	Wed May 14 17:31:09 2003
@@ -4664,7 +4664,7 @@ mega_is_bios_enabled(adapter_t *adapter)
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, sizeof(mbox));
+	memset(mbox, 0, sizeof(*mbox));
 
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
 
@@ -4697,7 +4697,7 @@ mega_enum_raid_scsi(adapter_t *adapter)
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, sizeof(mbox));
+	memset(mbox, 0, sizeof(*mbox));
 
 	/*
 	 * issue command to find out what channels are raid/scsi
@@ -4818,7 +4818,7 @@ mega_support_random_del(adapter_t *adapt
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, sizeof(mbox));
+	memset(mbox, 0, sizeof(*mbox));
 
 	/*
 	 * issue command
@@ -4847,7 +4847,7 @@ mega_support_ext_cdb(adapter_t *adapter)
 
 	mbox = (mbox_t *)raw_mbox;
 
-	memset(mbox, 0, sizeof (mbox));
+	memset(mbox, 0, sizeof(*mbox));
 	/*
 	 * issue command to find out if controller supports extended CDBs.
 	 */
diff -puN fs/cifs/md5.c~stanford-memcy-size-fixes fs/cifs/md5.c
--- 25/fs/cifs/md5.c~stanford-memcy-size-fixes	Wed May 14 17:31:09 2003
+++ 25-akpm/fs/cifs/md5.c	Wed May 14 17:31:09 2003
@@ -148,7 +148,7 @@ MD5Final(unsigned char digest[16], struc
 	MD5Transform(ctx->buf, (__u32 *) ctx->in);
 	byteReverse((unsigned char *) ctx->buf, 4);
 	memmove(digest, ctx->buf, 16);
-	memset(ctx, 0, sizeof (ctx));	/* In case it's sensitive */
+	memset(ctx, 0, sizeof(*ctx));	/* In case it's sensitive */
 }
 
 /* The four core functions - F1 is optimized somewhat */
diff -puN net/netrom/nr_route.c~stanford-memcy-size-fixes net/netrom/nr_route.c
--- 25/net/netrom/nr_route.c~stanford-memcy-size-fixes	Wed May 14 17:31:09 2003
+++ 25-akpm/net/netrom/nr_route.c	Wed May 14 17:31:09 2003
@@ -110,7 +110,8 @@ static int nr_add_node(ax25_address *nr,
 				kfree(nr_neigh);
 				return -ENOMEM;
 			}
-			memcpy(nr_neigh->digipeat, ax25_digi, sizeof(ax25_digi));
+			memcpy(nr_neigh->digipeat, ax25_digi,
+					sizeof(*ax25_digi));
 		}
 
 		spin_lock_bh(&nr_neigh_lock);
@@ -387,7 +388,7 @@ static int nr_add_neigh(ax25_address *ca
 			kfree(nr_neigh);
 			return -ENOMEM;
 		}
-		memcpy(nr_neigh->digipeat, ax25_digi, sizeof(ax25_digi));
+		memcpy(nr_neigh->digipeat, ax25_digi, sizeof(*ax25_digi));
 	}
 
 	spin_lock_bh(&nr_neigh_lock);
diff -puN sound/pci/emu10k1/emufx.c~stanford-memcy-size-fixes sound/pci/emu10k1/emufx.c
--- 25/sound/pci/emu10k1/emufx.c~stanford-memcy-size-fixes	Wed May 14 17:31:09 2003
+++ 25-akpm/sound/pci/emu10k1/emufx.c	Wed May 14 17:31:09 2003
@@ -2206,7 +2206,7 @@ static int snd_emu10k1_fx8010_info(emu10
 	unsigned short fxbus_mask, extin_mask, extout_mask;
 	int res;
 
-	memset(info, 0, sizeof(info));
+	memset(info, 0, sizeof(*info));
 	info->card = emu->card_type;
 	info->internal_tram_size = emu->fx8010.itram_size;
 	info->external_tram_size = emu->fx8010.etram_size;

_

