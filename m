Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268056AbTBRWs1>; Tue, 18 Feb 2003 17:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268066AbTBRWs1>; Tue, 18 Feb 2003 17:48:27 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:49365 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268056AbTBRWsX>;
	Tue, 18 Feb 2003 17:48:23 -0500
Message-Id: <200302182255.h1IMtD023605@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Andy Whitcroft <apw@shadowen.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Discontigmem support for the x440 
In-Reply-To: Message from Andy Whitcroft <apw@shadowen.org> 
   of "18 Feb 2003 22:39:41 GMT." <1045608022.22519.9.camel@voidhawk.shadowen.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Feb 2003 14:55:12 -0800
From: Patricia Gaughen <gone@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Andy - Thanks.  Martin had said that you had thought it was wrong, so I 
had been looking it over this morning and realized my error :-)  Hadn't worked 
up a solution just yet, though... so I'm glad to some code with your comment.  
I'll review your changes, and if it works I'll add it to my patch.  :-)  I 
really appreciate your feedback!

Thanks,
Pat

  > 
  > --=-VhECMrXvMAbfEiHvGxl0
  > Content-Type: text/plain
  > Content-Transfer-Encoding: 7bit
  > 
  > Pat,
  > 
  > Whilst looking at the Summit NUMA support I believe I have found a bug
  > in the memory hole handling.  Specifically, there appears to be a type
  > mismatch between get_zholes_size() returning a single long and
  > free_area_init_core() requiring a log array.  What I cannot adequately
  > explain is why this does not lead to a panic during boot.
  > 
  > Attached is a patch against 2.5.59-mjb6 which I believe should correct
  > this.  It has been tested in isolation and compile tested, but as I
  > don't have access to a test machine I cannot be sure it works.  I
  > believe some investigation is needed to understand why this bug does not
  > prevent booting, or lead to a large disparity in the zone free page
  > counts, perhaps the e820 map is helping here.
  > 
  > [gory details for the interested]
  > Under NUMA support  constructing the memory map we call
  > free_area_init_node() to initilialise the pglist_data and allocate the
  > memory map structures. As part of this we supply a per node, per memory
  > zone page count and a per node, per memory zone missing page count. 
  > These are used in free_area_init_core() to determine the true number of
  > pages per node, per zone.  In the existing summit code we parse the SRAT
  > in order to locate and size the inter-chunk gaps, on a per node basis. 
  > Later this is queried via get_zholes_size() from zone_init_sizes(). 
  > Unfortuantly, get_zholes_size is returning a single long representing
  > the per node total holes, whilst zone_init_sizes() requires an array of
  > longs one per zone (long[MAX_NR_ZONES]). In the zero holes case this
  > will be safe as if there are zero pages of hole then we pass an
  > apparently null pointer to get_zholes_size which is interpreted as
  > having no holes.  If the presence of any such holes a low-memory
  > reference would be passed potentially leading to an oops.
  > 
  > The attached patch modifies the memory chunk hole scan such that each
  > hole is allocated to one or more zones using the calculated zone
  > boundries, converting zholes_size[] from a per node count to a per node,
  > per zone count in a similar form to the associated zones[] array.
  > 
  > Cheers.
  > 
  > -apw
  > 
  > 
  > --=-VhECMrXvMAbfEiHvGxl0
  > Content-Disposition: attachment; filename=patch.mjb6-zholes
  > Content-Transfer-Encoding: quoted-printable
  > Content-Type: text/x-patch; name=patch.mjb6-zholes; charset=UTF-8
  > 
  > diff -X /home/apw/bin/makediff.excl -rupN linux-2.5.59-mjb6/arch/i386/kerne
  > =
  > l/srat.c linux-2.5.59-mjb6-zholes/arch/i386/kernel/srat.c
  > --- linux-2.5.59-mjb6/arch/i386/kernel/srat.c	2003-02-12 11:28:54.000
  > 000000=
  >  +0000
  > +++ linux-2.5.59-mjb6-zholes/arch/i386/kernel/srat.c	2003-02-13 13:1
  > 7:08.00=
  > 0000000 +0000
  > @@ -50,7 +50,8 @@ static u8 pxm_bitmap[PXM_BITMAP_LEN];	/*
  >  struct node_memory_chunk_s node_memory_chunk[MAXCLUMPS];
  > =20
  >  static int num_memory_chunks;		/* total number of memory chunk
  > s */
  > -static unsigned long zholes_size[MAX_NUMNODES];
  > +static int zholes_size_init;
  > +static unsigned long zholes_size[MAX_NUMNODES * MAX_NR_ZONES];
  > =20
  >  unsigned long node_start_pfn[MAX_NUMNODES];
  >  unsigned long node_end_pfn[MAX_NUMNODES];
  > @@ -151,6 +152,49 @@ static void __init parse_memory_affinity
  >  		 "enabled and removable" : "enabled" ) );
  >  }
  > =20
  > +#if MAX_NR_ZONES !=3D 3
  > +#error "MAX_NR_ZONES !=3D 3, chunk_to_zone requires review"
  > +#endif
  > +/* Take a chunk of pages from page frame cstart to cend and count the numb
  > =
  > er
  > + * of pages in each zone, returned via zones[].
  > + */
  > +static __init void chunk_to_zones(unsigned long cstart, unsigned long cend
  > =
  > ,=20
  > +		unsigned long *zones)
  > +{
  > +	unsigned long max_dma;
  > +	extern unsigned long max_low_pfn;
  > +
  > +	int z;
  > +	unsigned long rend;
  > +
  > +	/* FIXME: MAX_DMA_ADDRESS and max_low_pfn are trying to provide
  > +	 * similarly scoped information and should be handled in a consistant
  > +	 * manner.
  > +	 */
  > +	max_dma =3D virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
  > +
  > +	/* Split the hole into the zones in which it falls.  Repeatedly
  > +	 * take the segment in which the remaining hole starts, round it
  > +	 * to the end of that zone.
  > +	 */
  > +	memset(zones, 0, MAX_NR_ZONES * sizeof(long));
  > +	while (cstart < cend) {
  > +		if (cstart < max_dma) {
  > +			z =3D ZONE_DMA;
  > +			rend =3D (cend < max_dma)? cend : max_dma;
  > +
  > +		} else if (cstart < max_low_pfn) {
  > +			z =3D ZONE_NORMAL;
  > +			rend =3D (cend < max_low_pfn)? cend : max_low_pfn;
  > +
  > +		} else {
  > +			z =3D ZONE_HIGHMEM;
  > +			rend =3D cend;
  > +		}
  > +		zones[z] +=3D rend - cstart;
  > +		cstart =3D rend;
  > +	}
  > +}
  > =20
  >  /* Parse the ACPI Static Resource Affinity Table */
  >  static int __init acpi20_parse_srat(struct acpi_table_srat *sratp)
  > @@ -242,10 +286,6 @@ static int __init acpi20_parse_srat(stru
  >  				} else { /* We've found another chunk of memory
  >  for the node */
  >  					if (node_start_pfn[nid] < node_memory_c
  > hunk[j].start_pfn) {
  >  						printk("found a another chunk o
  > n nid %d, chunk %d\n", nid, j);
  > -
  > -						zholes_size[nid] =3D zholes_siz
  > e[nid] +
  > -							(node_memory_chunk[j].s
  > tart_pfn
  > -							 - node_end_pfn[nid]);
  >  						node_end_pfn[nid] =3D node_memo
  > ry_chunk[j].end_pfn;
  >  					}
  >  				}
  > @@ -396,10 +436,53 @@ printk("Begin table scan....\n");
  >  	wbinvd();
  >  }
  > =20
  > -unsigned long __init get_zholes_size(int nid)
  > +/* For each node run the memory list to determine whether there are
  > + * any memory holes.  For each hole determine which ZONE they fall
  > + * into.
  > + *
  > + * NOTE#1: this requires knowledge of the zone boundries and so
  > + * _cannot_ be performed before those are calculated in setup_memory.
  > + *=20
  > + * NOTE#2: we rely on the fact that the memory chunks are ordered by
  > + * start pfn number during setup.
  > + */
  > +static void __init get_zholes_init(void)
  >  {
  > +	int nid;
  > +	int c;
  > +	int first;
  > +	unsigned long end =3D 0;
  > +
  > +	for (nid =3D 0; nid < numnodes; nid++) {
  > +		first =3D 1;
  > +		for (c =3D 0; c < num_memory_chunks; c++){
  > +			if (node_memory_chunk[c].nid =3D=3D nid) {
  > +				if (first) {
  > +					end =3D node_memory_chunk[c].end_pfn;
  > +					first =3D 0;
  > +
  > +				} else {
  > +					/* Record any gap between this chunk
  > +					 * and the previous chunk on this node
  > +					 * against the zones it spans.
  > +					 */
  > +					chunk_to_zones(end,
  > +						node_memory_chunk[c].start_pfn,
  > +						&zholes_size[nid * MAX_NR_ZONES
  > ]);
  > +				}
  > +			}
  > +		}
  > +	}
  > +}
  > +
  > +unsigned long * __init get_zholes_size(int nid)
  > +{
  > +	if (!zholes_size_init) {
  > +		zholes_size_init++;
  > +		get_zholes_init();
  > +	}
  >  	if((nid >=3D numnodes) | (nid >=3D MAX_NUMNODES))
  >  		printk("%s: nid =3D %d is invalid. numnodes =3D %d",
  >  		       __FUNCTION__, nid, numnodes);
  > -	return zholes_size[nid];
  > +	return &zholes_size[nid * MAX_NR_ZONES];
  >  }
  > diff -X /home/apw/bin/makediff.excl -rupN linux-2.5.59-mjb6/arch/i386/mm/di
  > =
  > scontig.c linux-2.5.59-mjb6-zholes/arch/i386/mm/discontig.c
  > --- linux-2.5.59-mjb6/arch/i386/mm/discontig.c	2003-02-12 11:28:54.000
  > 00000=
  > 0 +0000
  > +++ linux-2.5.59-mjb6-zholes/arch/i386/mm/discontig.c	2003-02-13 13:0
  > 3:34.0=
  > 00000000 +0000
  > @@ -290,7 +290,7 @@ void __init zone_sizes_init(void)
  > =20
  >  	for (nid =3D 0; nid < numnodes; nid++) {
  >  		unsigned long zones_size[MAX_NR_ZONES] =3D {0, 0, 0};
  > -		unsigned long zholes_size;
  > +		unsigned long *zholes_size;
  >  		unsigned int max_dma;
  > =20
  >  		unsigned long low =3D max_low_pfn;
  > @@ -331,7 +331,7 @@ void __init zone_sizes_init(void)
  >  			lmem_map &=3D PAGE_MASK;
  >  			free_area_init_node(nid, NODE_DATA(nid),=20
  >  				(struct page *)lmem_map, zones_size,=20
  > -				start, (unsigned long *)zholes_size);
  > +				start, zholes_size);
  >  		}
  >  	}
  >  	return;
  > diff -X /home/apw/bin/makediff.excl -rupN linux-2.5.59-mjb6/include/asm-i38
  > =
  > 6/srat.h linux-2.5.59-mjb6-zholes/include/asm-i386/srat.h
  > --- linux-2.5.59-mjb6/include/asm-i386/srat.h	2003-02-12 11:28:55.000
  > 000000=
  >  +0000
  > +++ linux-2.5.59-mjb6-zholes/include/asm-i386/srat.h	2003-02-13 11:0
  > 2:43.00=
  > 0000000 +0000
  > @@ -34,7 +34,7 @@
  >  #define MAXCLUMPS		(MAX_CLUMPS_PER_NODE * MAX_NUMNODES)
  >  extern int pfn_to_nid(unsigned long);
  >  extern void get_memcfg_from_srat(void);
  > -extern unsigned long get_zholes_size(int);
  > +extern unsigned long *get_zholes_size(int);
  >  #define get_memcfg_numa() get_memcfg_from_srat()
  > =20
  >  /*
  > 
  > --=-VhECMrXvMAbfEiHvGxl0--
  > 


