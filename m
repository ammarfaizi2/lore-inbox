Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVo+9ickhBNQzLSDufAtn9XuaNGQ==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Fri, 02 Jan 2004 16:17:28 +0000
Message-ID: <001701c415a3$ef628400$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
To: <Administrator@osdl.org>
Cc: <arjanv@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
        <packet-writing@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ext2 on a CD-RW
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com><20040101162427.4c6c020b.akpm@osdl.org> <m2llorkuhn.fsf@telia.com><1073034412.4429.1.camel@laptop.fenrus.com> <m2k74a8vyr.fsf@telia.com><20040102105915.GO5523@suse.de>
X-Mailer: Microsoft CDO for Exchange 2000
From: "Peter Osterlund" <petero2@telia.com>
Date: Mon, 29 Mar 2004 16:38:51 +0100
In-Reply-To: <20040102105915.GO5523@suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
Content-Type: text/plain;
	charset="us-ascii"
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:38:52.0828 (UTC) FILETIME=[F04765C0:01C415A3]

Jens Axboe <axboe@suse.de> writes:

> On Fri, Jan 02 2004, Peter Osterlund wrote:
> > 
> > Old versions of the packet writing code did just that, but Jens told
> > me that bio splitting was evil, so when the merge_bvec_fn
> > functionality was added to the kernel, I started to use it.
> > 
> >         http://lists.suse.com/archive/packet-writing/2002-Aug/0044.html
> 
> Splitting is evil, but unfortunately it's a necessary evil... There are
> a few kernel helpers to make supporting it easier (see bio_split()). Not
> so sure how well that'll work for you, you may have to do the grunt work
> yourself.

It seems like bio_split() does exactly what I need. The patch below
makes 2kb blocksize ext2 work and also fixes the performance problem
compared to 4kb blocksize ext2. Thanks to everyone involved for their
help.

--- linux/drivers/block/pktcdvd.c.old	2004-01-02 16:58:52.000000000 +0100
+++ linux/drivers/block/pktcdvd.c	2004-01-02 16:59:26.000000000 +0100
@@ -2083,11 +2083,23 @@
 		(unsigned long long)bio->bi_sector,
 		(unsigned long long)(bio->bi_sector + bio_sectors(bio)));
 
-	/* Some debug code to make sure the merge_bvec_fn function is working. */
+	/* Check if we have to split the bio */
 	{
+		struct bio_pair *bp;
 		sector_t last_zone;
+		int first_sectors;
+
 		last_zone = ZONE(bio->bi_sector + bio_sectors(bio) - 1, pd);
-		BUG_ON(last_zone != zone);
+		if (last_zone != zone) {
+			BUG_ON(last_zone != zone + pd->settings.size);
+			first_sectors = last_zone - bio->bi_sector;
+			bp = bio_split(bio, bio_split_pool, first_sectors);
+			BUG_ON(!bp);
+			pkt_make_request(q, &bp->bio1);
+			pkt_make_request(q, &bp->bio2);
+			bio_pair_release(bp);
+			return 0;
+		}
 	}
 
 	/*
@@ -2153,6 +2165,15 @@
 	sector_t zone = ZONE(bio->bi_sector, pd);
 	int used = ((bio->bi_sector - zone) << 9) + bio->bi_size;
 	int remaining = (pd->settings.size << 9) - used;
+	int remaining2;
+
+	/*
+	 * A bio <= PAGE_SIZE must be allowed. If it crosses a packet
+	 * boundary, pkt_make_request() will split the bio.
+	 */
+	remaining2 = PAGE_SIZE - bio->bi_size;
+	remaining = max_t(int, remaining, remaining2);
+
 	BUG_ON(remaining < 0);
 	return remaining;
 }

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
