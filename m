Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbSK2BYK>; Thu, 28 Nov 2002 20:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266924AbSK2BXS>; Thu, 28 Nov 2002 20:23:18 -0500
Received: from dp.samba.org ([66.70.73.150]:26553 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266917AbSK2BWs>;
	Thu, 28 Nov 2002 20:22:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Wang, Stanley" <stanley.wang@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       dwmw2@twiddle.net
Subject: Re: [BUG] [2.5.49] symbol_get doesn't work 
In-reply-to: Your message of "Thu, 28 Nov 2002 09:15:43 +0800."
             <957BD1C2BF3CD411B6C500A0C944CA2601F116A1@pdsmsx32.pd.intel.com> 
Date: Fri, 29 Nov 2002 11:01:50 +1100
Message-Id: <20021129013010.5DEAF2C2EE@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <957BD1C2BF3CD411B6C500A0C944CA2601F116A1@pdsmsx32.pd.intel.com> you
 write:
> Hi, Rusty
> Thanks for your respondence.
> You means that the purpose of using symbols_get() is just adding =
> module's
> reference count, right?
> If so, I think we don't need a pointer to be returned by symbol_get(). =
> We
> could use the symbols desired
> directly after we called symbol_get().=20
> How do you think about it ?

Hi Wang,

	No, you do *not* normally need to use symbol_get(): you just
use the symbol like normal and the loader will make sure reference
counts are adjusted etc.

	Here's an example of use, from my (completely untested) "make
mtd use symbol_get()" patch, which allows mtd to look for support for
a given command set at runtime (rather than forcing all command set
modules to be present to load at all):

================
typedef struct mtd_info *cfi_cmdset_fn_t(struct map_info *, int);
 
static struct mtd_info *unknown_cmdset(struct map_info *map, int primary)
{
	struct cfi_private *cfi = map->fldrv_priv;
	__u16 type = primary?cfi->cfiq->P_ID:cfi->cfiq->A_ID;

	printk(KERN_NOTICE "Support for command set %04X not present\n",
	       type);
	return NULL;
}

/* when we are built without module support, so we still link */
cfi_cmdset_fn_t cfi_cmdset_0001 __attribute__((weak, alias("unknown_cmdset")));
cfi_cmdset_fn_t cfi_cmdset_0002 __attribute__((weak, alias("unknown_cmdset")));
cfi_cmdset_fn_t cfi_cmdset_0003 __attribute__((weak, alias("unknown_cmdset")));

static inline struct mtd_info *cfi_cmdset_unknown(struct map_info *map, 
						  int primary)
{
	struct cfi_private *cfi = map->fldrv_priv;
	__u16 type = primary?cfi->cfiq->P_ID:cfi->cfiq->A_ID;
	cfi_cmdset_fn_t *probe_function = NULL;

	switch (type) {
	case 1:
		probe_function = symbol_get(cfi_cmdset_0001);
		break;
	case 2:
		probe_function = symbol_get(cfi_cmdset_0002);
		break;
	case 3:
		probe_function = symbol_get(cfi_cmdset_0003);
		break;
	}
	if (probe_function) {
 		struct mtd_info *mtd;
 
 		mtd = (*probe_function)(map, primary);
 		return mtd;
 	}
	return unknown_cmdset(map, primary);
 }
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
