Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263392AbTCNQJF>; Fri, 14 Mar 2003 11:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263401AbTCNQJF>; Fri, 14 Mar 2003 11:09:05 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:11158 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263392AbTCNQIf>; Fri, 14 Mar 2003 11:08:35 -0500
Date: Fri, 14 Mar 2003 17:19:16 +0100
From: Joern Engel <joern@wohnheim.fh-wedel.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jonas Holmberg <jonas.holmberg@axis.com>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix stack usage for amd_flash.c
Message-ID: <20030314161916.GA23161@wohnheim.fh-wedel.de>
References: <20030314154642.GC27154@wohnheim.fh-wedel.de> <1047657910.14792.153.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1047657910.14792.153.camel@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 March 2003 16:05:10 +0000, David Woodhouse wrote:
> On Fri, 2003-03-14 at 15:46, Joern Engel wrote:
> 
> Urgh. That should never have been on the stack in the first place. Make
> it static. The comment about being deallocated when the probe is done is
> bogus -- where do we think we get the contents of the table from when
> _entering_ the probe function anyway? It's elsewhere in the kernel
> image.

Ok, done.
Is the new patch ok?

> No. You can't make that __initdata because the functions which _call_ it
> aren't __init. You can load map drivers (e.g. pcmcia) as modules which
> try to probe for all kinds of chips.  

ack.

> Also note that all but the CFI-based drivers are deprecated. We have
> old-style probes which allow us to use the CFI back-end drivers with
> non-CFI chips anyway.

Right. But since 2.[567] is going towards 4k kernel stack, those
drivers should be fixed or revomed. If you don't remove it, I'll try
to fix it. :)

> Btw you're sending out 8-bit mail with charset 'unknown-8bit'. What
> should be a ö isn't.

Correct. I noticed that my inline patches were getting screwed up
somehow and played around with the character set. It turned out that
lkml is converting my mails to QP, no matter what I do. So the
solution appears to be to include the important people in TO|CC and
ignore the QP problem.

Unless you know a better solution, of course.

Jörn

-- 
Data dominates. If you've chosen the right data structures and organized
things well, the algorithms will almost always be self-evident. Data
structures, not algorithms, are central to programming.
-- Rob Pike

--- linux-2.5.64/drivers/mtd/chips/amd_flash.c	Wed Mar 12 14:16:34 2003
+++ linux-2.5.64-i2o/drivers/mtd/chips/amd_flash.c	Thu Mar 13 13:18:10 2003
@@ -417,205 +417,202 @@
 
 
 
-static struct mtd_info *amd_flash_probe(struct map_info *map)
+static const struct amd_flash_info table[] = {
 {
-	/* Keep this table on the stack so that it gets deallocated after the
-	 * probe is done.
-	 */
-	const struct amd_flash_info table[] = {
-	{
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29LV160DT,
-		.name = "AMD AM29LV160DT",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
-			{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29LV160DB,
-		.name = "AMD AM29LV160DB",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
-			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_TOSHIBA,
-		.dev_id = TC58FVT160,
-		.name = "Toshiba TC58FVT160",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
-			{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_FUJITSU,
-		.dev_id = MBM29LV160TE,
-		.name = "Fujitsu MBM29LV160TE",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
-			{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_TOSHIBA,
-		.dev_id = TC58FVB160,
-		.name = "Toshiba TC58FVB160",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
-			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_FUJITSU,
-		.dev_id = MBM29LV160BE,
-		.name = "Fujitsu MBM29LV160BE",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
-			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29LV800BB,
-		.name = "AMD AM29LV800BB",
-		.size = 0x00100000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
-			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 15 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29F800BB,
-		.name = "AMD AM29F800BB",
-		.size = 0x00100000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
-			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 15 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29LV800BT,
-		.name = "AMD AM29LV800BT",
-		.size = 0x00100000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
-			{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29F800BT,
-		.name = "AMD AM29F800BT",
-		.size = 0x00100000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
-			{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29LV800BB,
-		.name = "AMD AM29LV800BB",
-		.size = 0x00100000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
-			{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_ST,
-		.dev_id = M29W800T,
-		.name = "ST M29W800T",
-		.size = 0x00100000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
-			{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_ST,
-		.dev_id = M29W160DT,
-		.name = "ST M29W160DT",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
-			{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_ST,
-		.dev_id = M29W160DB,
-		.name = "ST M29W160DB",
-		.size = 0x00200000,
-		.numeraseregions = 4,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
-			{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
-			{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
-			{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29BDS323D,
-		.name = "AMD AM29BDS323D",
-		.size = 0x00400000,
-		.numeraseregions = 3,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 48 },
-			{ .offset = 0x300000, .erasesize = 0x10000, .numblocks = 15 },
-			{ .offset = 0x3f0000, .erasesize = 0x02000, .numblocks  = 8 },
-		}
-	}, {
-		.mfr_id = MANUFACTURER_AMD,
-		.dev_id = AM29BDS643D,
-		.name = "AMD AM29BDS643D",
-		.size = 0x00800000,
-		.numeraseregions = 3,
-		.regions = {
-			{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 96 },
-			{ .offset = 0x600000, .erasesize = 0x10000, .numblocks = 31 },
-			{ .offset = 0x7f0000, .erasesize = 0x02000, .numblocks  = 8 },
-		}
-	} 
-	};
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29LV160DT,
+	.name = "AMD AM29LV160DT",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
+		{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29LV160DB,
+	.name = "AMD AM29LV160DB",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+		{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_TOSHIBA,
+	.dev_id = TC58FVT160,
+	.name = "Toshiba TC58FVT160",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
+		{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_FUJITSU,
+	.dev_id = MBM29LV160TE,
+	.name = "Fujitsu MBM29LV160TE",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
+		{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_TOSHIBA,
+	.dev_id = TC58FVB160,
+	.name = "Toshiba TC58FVB160",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+		{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_FUJITSU,
+	.dev_id = MBM29LV160BE,
+	.name = "Fujitsu MBM29LV160BE",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+		{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29LV800BB,
+	.name = "AMD AM29LV800BB",
+	.size = 0x00100000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+		{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 15 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29F800BB,
+	.name = "AMD AM29F800BB",
+	.size = 0x00100000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+		{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 15 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29LV800BT,
+	.name = "AMD AM29LV800BT",
+	.size = 0x00100000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
+		{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29F800BT,
+	.name = "AMD AM29F800BT",
+	.size = 0x00100000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
+		{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29LV800BB,
+	.name = "AMD AM29LV800BB",
+	.size = 0x00100000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
+		{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_ST,
+	.dev_id = M29W800T,
+	.name = "ST M29W800T",
+	.size = 0x00100000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 15 },
+		{ .offset = 0x0F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x0F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x0FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_ST,
+	.dev_id = M29W160DT,
+	.name = "ST M29W160DT",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 31 },
+		{ .offset = 0x1F0000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x1F8000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x1FC000, .erasesize = 0x04000, .numblocks  = 1 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_ST,
+	.dev_id = M29W160DB,
+	.name = "ST M29W160DB",
+	.size = 0x00200000,
+	.numeraseregions = 4,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x04000, .numblocks  = 1 },
+		{ .offset = 0x004000, .erasesize = 0x02000, .numblocks  = 2 },
+		{ .offset = 0x008000, .erasesize = 0x08000, .numblocks  = 1 },
+		{ .offset = 0x010000, .erasesize = 0x10000, .numblocks = 31 }
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29BDS323D,
+	.name = "AMD AM29BDS323D",
+	.size = 0x00400000,
+	.numeraseregions = 3,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 48 },
+		{ .offset = 0x300000, .erasesize = 0x10000, .numblocks = 15 },
+		{ .offset = 0x3f0000, .erasesize = 0x02000, .numblocks  = 8 },
+	}
+}, {
+	.mfr_id = MANUFACTURER_AMD,
+	.dev_id = AM29BDS643D,
+	.name = "AMD AM29BDS643D",
+	.size = 0x00800000,
+	.numeraseregions = 3,
+	.regions = {
+		{ .offset = 0x000000, .erasesize = 0x10000, .numblocks = 96 },
+		{ .offset = 0x600000, .erasesize = 0x10000, .numblocks = 31 },
+		{ .offset = 0x7f0000, .erasesize = 0x02000, .numblocks  = 8 },
+	}
+} 
+};
 
+static struct mtd_info *amd_flash_probe(struct map_info *map)
+{
 	struct mtd_info *mtd;
 	struct flchip chips[MAX_AMD_CHIPS];
 	int table_pos[MAX_AMD_CHIPS];
