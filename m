Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289039AbSA0XCb>; Sun, 27 Jan 2002 18:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289051AbSA0XCX>; Sun, 27 Jan 2002 18:02:23 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:29146 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S289039AbSA0XCF>; Sun, 27 Jan 2002 18:02:05 -0500
Message-ID: <3C54871E.80621B4E@oracle.com>
Date: Mon, 28 Jan 2002 00:02:54 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        John Levon <movement@marcelothewonderpenguin.com>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] Fix 2.5.3pre reiserfs BUG() at boot time
In-Reply-To: <20020125180149.GB45738@compsoc.man.ac.uk> <Pine.LNX.4.33.0201251006220.1632-100000@penguin.transmeta.com> <20020125204911.A17190@wotan.suse.de> <20020125133814.U763@lynx.adilger.int> <20020125231555.A22583@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Fri, Jan 25, 2002 at 01:38:14PM -0700, Andreas Dilger wrote:
> > So, what exactly does the above do now (hint: p and pc are both local
> > so they cannot be referenced anywhere else)?  It used to check that you
> > weren't trying to add two caches with the same name.  This isn't
> > possible with caches from broken modules anymore as they have no name.
> 
> I have fixed the loop now to check for names again.
> 
> > When calling kmem_cache_destroy() on a non-empty slab we should just
> > malloc some memory with the old cache name + "_leaked" for the name
> > pointer.  At least then we have a sane chance of figuring out what caused
> > the problem, instead of having a bunch of "broken" entries in the table,
> > and remove the above "broken" check entirely (we will always have a name).
> 
> I don't like this because it complicates the code too much.
> "broken" should be enough to debug it.
> 
> New patch appended. Linus please apply if you didn't already.
> 
> -Andi



2.5.3-pre5 + this patch still can't boot my system. I haven't had
 time to copy down oops at boot, will do if needed.

Thanks & ciao,



> Index: mm/slab.c
> ===================================================================
> RCS file: /cvs/linux/mm/slab.c,v
> retrieving revision 1.66
> diff -u -u -r1.66 slab.c
> --- mm/slab.c   2002/01/08 16:00:20     1.66
> +++ mm/slab.c   2002/01/25 22:14:40
> @@ -186,8 +186,6 @@
>   * manages a cache.
>   */
> 
> -#define CACHE_NAMELEN  20      /* max name length for a slab cache */
> -
>  struct kmem_cache_s {
>  /* 1) each alloc & free */
>         /* full, partial first, then free */
> @@ -225,7 +223,7 @@
>         unsigned long           failures;
> 
>  /* 3) cache creation/removal */
> -       char                    name[CACHE_NAMELEN];
> +       const char                      *name;
>         struct list_head        next;
>  #ifdef CONFIG_SMP
>  /* 4) per-cpu data */
> @@ -335,6 +333,7 @@
>         kmem_cache_t    *cs_dmacachep;
>  } cache_sizes_t;
> 
> +/* These are the default caches for kmalloc. Custom caches can have other sizes. */
>  static cache_sizes_t cache_sizes[] = {
>  #if PAGE_SIZE == 4096
>         {    32,        NULL, NULL},
> @@ -353,6 +352,26 @@
>         {131072,        NULL, NULL},
>         {     0,        NULL, NULL}
>  };
> +/* Must match cache_sizes above. Out of line to keep cache footprint low. */
> +#define CN(x) { x, x ## "(DMA)" }
> +static char cache_names[][2][18] = {
> +#if PAGE_SIZE == 4096
> +       CN("size-32"),
> +#endif
> +       CN("size-64"),
> +       CN("size-128"),
> +       CN("size-256"),
> +       CN("size-512"),
> +       CN("size-1024"),
> +       CN("size-2048"),
> +       CN("size-4096"),
> +       CN("size-8192"),
> +       CN("size-16384"),
> +       CN("size-32768"),
> +       CN("size-65536"),
> +       CN("size-131072")
> +};
> +#undef CN
> 
>  /* internal cache of cache description objs */
>  static kmem_cache_t cache_cache = {
> @@ -437,7 +456,6 @@
>  void __init kmem_cache_sizes_init(void)
>  {
>         cache_sizes_t *sizes = cache_sizes;
> -       char name[20];
>         /*
>          * Fragmentation resistance on low memory - only use bigger
>          * page orders on machines with more than 32MB of memory.
> @@ -450,9 +468,9 @@
>                  * eliminates "false sharing".
>                  * Note for systems short on memory removing the alignment will
>                  * allow tighter packing of the smaller caches. */
> -               sprintf(name,"size-%Zd",sizes->cs_size);
>                 if (!(sizes->cs_cachep =
> -                       kmem_cache_create(name, sizes->cs_size,
> +                       kmem_cache_create(cache_names[sizes-cache_sizes][0],
> +                                         sizes->cs_size,
>                                         0, SLAB_HWCACHE_ALIGN, NULL, NULL))) {
>                         BUG();
>                 }
> @@ -462,9 +480,10 @@
>                         offslab_limit = sizes->cs_size-sizeof(slab_t);
>                         offslab_limit /= 2;
>                 }
> -               sprintf(name, "size-%Zd(DMA)",sizes->cs_size);
> -               sizes->cs_dmacachep = kmem_cache_create(name, sizes->cs_size, 0,
> -                             SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
> +               sizes->cs_dmacachep = kmem_cache_create(
> +                   cache_names[sizes-cache_sizes][1],
> +                       sizes->cs_size, 0,
> +                       SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
>                 if (!sizes->cs_dmacachep)
>                         BUG();
>                 sizes++;
> @@ -604,6 +623,11 @@
>   * Cannot be called within a int, but can be interrupted.
>   * The @ctor is run when new pages are allocated by the cache
>   * and the @dtor is run before the pages are handed back.
> + *
> + * @name must be valid until the cache is destroyed. This implies that
> + * the module calling this has to destroy the cache before getting
> + * unloaded.
> + *
>   * The flags are
>   *
>   * %SLAB_POISON - Poison the slab with a known test pattern (a5a5a5a5)
> @@ -632,7 +656,6 @@
>          * Sanity checks... these are all serious usage bugs.
>          */
>         if ((!name) ||
> -               ((strlen(name) >= CACHE_NAMELEN - 1)) ||
>                 in_interrupt() ||
>                 (size < BYTES_PER_WORD) ||
>                 (size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
> @@ -797,8 +820,7 @@
>                 cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
>         cachep->ctor = ctor;
>         cachep->dtor = dtor;
> -       /* Copy name over so we don't have problems with unloaded modules */
> -       strcpy(cachep->name, name);
> +       cachep->name = name;
> 
>  #ifdef CONFIG_SMP
>         if (g_cpucache_up)
> @@ -811,10 +833,11 @@
> 
>                 list_for_each(p, &cache_chain) {
>                         kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
> -
> -                       /* The name field is constant - no lock needed. */
> -                       if (!strcmp(pc->name, name))
> -                               BUG();
> +                       char tmp;
> +                       if (get_user(tmp,pc->name))
> +                               continue;
> +                       if (!strcmp(pc->name,name))
> +                               BUG();
>                 }
>         }
> 
> @@ -1878,6 +1901,7 @@
>                 unsigned long   num_objs;
>                 unsigned long   active_slabs = 0;
>                 unsigned long   num_slabs;
> +               const char *name;
>                 cachep = list_entry(p, kmem_cache_t, next);
> 
>                 spin_lock_irq(&cachep->spinlock);
> @@ -1906,8 +1930,15 @@
>                 num_slabs+=active_slabs;
>                 num_objs = num_slabs*cachep->num;
> 
> +               name = cachep->name;
> +               {
> +               char tmp;
> +               if (get_user(tmp, name))
> +                       name = "broken";
> +               }
> +
>                 len += sprintf(page+len, "%-17s %6lu %6lu %6u %4lu %4lu %4u",
> -                       cachep->name, active_objs, num_objs, cachep->objsize,
> +                       name, active_objs, num_objs, cachep->objsize,
>                         active_slabs, num_slabs, (1<<cachep->gfporder));
> 
>  #if STATS

--alessandro

 "this machine will, will not communicate
   these thoughts and the strain I am under
  be a world child, form a circle before we all go under"
                         (Radiohead, "Street Spirit [fade out]")
