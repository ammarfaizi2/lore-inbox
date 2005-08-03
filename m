Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVHCGoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVHCGoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVHCGoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:44:12 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:61223 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262074AbVHCGoK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:44:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nsWpdR5NIHEzxPGWK5h+SLKPmIMXbKCh9Ny+ZnON/x9Z+qN+5kFHRnL8n7kcHmKlqXeLQj41/g4RUU3UYYswa05Ltb3Fwhr6fZTTgtahYmPTtvm4CFxdwdJlXtebU1MdpgR4eIt3LXLfDCbaXB5ZqI2VaQbnPdIpJZSez3gX25U=
Message-ID: <84144f0205080223445375c907@mail.gmail.com>
Date: Wed, 3 Aug 2005 09:44:06 +0300
From: Pekka Enberg <penberg@gmail.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: [PATCH 00/14] GFS
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <20050802071828.GA11217@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050802071828.GA11217@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Some more comments below.

                                Pekka

On 8/2/05, David Teigland <teigland@redhat.com> wrote:
> +/**
> + * inode_create - create a struct gfs2_inode
> + * @i_gl: The glock covering the inode
> + * @inum: The inode number
> + * @io_gl: the iopen glock to acquire/hold (using holder in new gfs2_inode)
> + * @io_state: the state the iopen glock should be acquired in
> + * @ipp: pointer to put the returned inode in
> + *
> + * Returns: errno
> + */
> +
> +static int inode_create(struct gfs2_glock *i_gl, struct gfs2_inum *inum,
> +			struct gfs2_glock *io_gl, unsigned int io_state,
> +			struct gfs2_inode **ipp)
> +{
> +	struct gfs2_sbd *sdp = i_gl->gl_sbd;
> +	struct gfs2_inode *ip;
> +	int error = 0;
> +
> +	RETRY_MALLOC(ip = kmem_cache_alloc(gfs2_inode_cachep, GFP_KERNEL), ip);

Why do you want to do this? The callers can handle ENOMEM just fine.

> +/**
> + * gfs2_random - Generate a random 32-bit number
> + *
> + * Generate a semi-crappy 32-bit pseudo-random number without using
> + * floating point.
> + *
> + * The PRNG is from "Numerical Recipes in C" (second edition), page 284.
> + *
> + * Returns: a 32-bit random number
> + */
> +
> +uint32_t gfs2_random(void)
> +{
> +	gfs2_random_number = 0x0019660D * gfs2_random_number + 0x3C6EF35F;
> +	return gfs2_random_number;
> +}

Please consider moving this into lib/random.c. This one already appears in
drivers/net/hamradio/dmascc.c.

> +/**
> + * gfs2_hash - hash an array of data
> + * @data: the data to be hashed
> + * @len: the length of data to be hashed
> + *
> + * Take some data and convert it to a 32-bit hash.
> + *
> + * This is the 32-bit FNV-1a hash from:
> + * http://www.isthe.com/chongo/tech/comp/fnv/
> + *
> + * Returns: the hash
> + */
> +
> +uint32_t gfs2_hash(const void *data, unsigned int len)
> +{
> +     uint32_t h = 0x811C9DC5;
> +     h = hash_more_internal(data, len, h);
> +     return h;
> +}

Is there a reason why you cannot use <linux/hash.h> or <linux/jhash.h>?

> +void gfs2_sort(void *base, unsigned int num_elem, unsigned int size,
> +            int (*compar) (const void *, const void *))
> +{
> +     register char *pbase = (char *)base;
> +     int i, j, k, h;
> +     static int cols[16] = {1391376, 463792, 198768, 86961,
> +                            33936, 13776, 4592, 1968,
> +                            861, 336, 112, 48,
> +                            21, 7, 3, 1};
> +
> +     for (k = 0; k < 16; k++) {
> +             h = cols[k];
> +             for (i = h; i < num_elem; i++) {
> +                     j = i;
> +                     while (j >= h &&
> +                            (*compar)((void *)(pbase + size * (j - h)),
> +                                      (void *)(pbase + size * j)) > 0) {
> +                             SWAP(pbase + size * j,
> +                                  pbase + size * (j - h),
> +                                  size);
> +                             j = j - h;
> +                     }
> +             }
> +     }
> +}

Please use sort() from lib/sort.c.

> +/**
> + * gfs2_io_error_inode_i - Flag an inode I/O error and withdraw
> + * @ip:
> + * @function:
> + * @file:
> + * @line:

Please drop empty kerneldoc tags. (Appears in various other places as well.)

> +#define RETRY_MALLOC(do_this, until_this) \
> +for (;;) { \
> +     { do_this; } \
> +     if (until_this) \
> +             break; \
> +     if (time_after_eq(jiffies, gfs2_malloc_warning + 5 * HZ)) { \
> +             printk("GFS2: out of memory: %s, %u\n", __FILE__, __LINE__); \
> +             gfs2_malloc_warning = jiffies; \
> +     } \
> +     yield(); \
> +}

Please drop this.

> +int gfs2_acl_create(struct gfs2_inode *dip, struct gfs2_inode *ip)
> +{
> +             struct gfs2_sbd *sdp = dip->i_sbd;
> +     struct posix_acl *acl = NULL;
> +     struct gfs2_ea_request er;
> +     mode_t mode = ip->i_di.di_mode;
> +     int error;
> +
> +     if (!sdp->sd_args.ar_posix_acl)
> +             return 0;
> +     if (S_ISLNK(ip->i_di.di_mode))
> +             return 0;
> +
> +     memset(&er, 0, sizeof(struct gfs2_ea_request));
> +     er.er_type = GFS2_EATYPE_SYS;
> +
> +     error = acl_get(dip, ACL_DEFAULT, &acl, NULL,
> +                     &er.er_data, &er.er_data_len);
> +     if (error)
> +             return error;
> +     if (!acl) {
> +             mode &= ~current->fs->umask;
> +             if (mode != ip->i_di.di_mode)
> +                     error = munge_mode(ip, mode);
> +             return error;
> +     }
> +
> +     {
> +             struct posix_acl *clone = posix_acl_clone(acl, GFP_KERNEL);
> +             error = -ENOMEM;
> +             if (!clone)
> +                     goto out;
> +             gfs2_memory_add(clone);
> +             gfs2_memory_rm(acl);
> +             posix_acl_release(acl);
> +             acl = clone;
> +     }

Please make this a real function. It is duplicated below.

> +     if (error > 0) {
> +             er.er_name = GFS2_POSIX_ACL_ACCESS;
> +             er.er_name_len = GFS2_POSIX_ACL_ACCESS_LEN;
> +             posix_acl_to_xattr(acl, er.er_data, er.er_data_len);
> +             er.er_mode = mode;
> +             er.er_flags = GFS2_ERF_MODE;
> +             error = gfs2_system_eaops.eo_set(ip, &er);
> +             if (error)
> +                     goto out;
> +     } else
> +             munge_mode(ip, mode);
> +
> + out:
> +     gfs2_memory_rm(acl);
> +     posix_acl_release(acl);
> +     kfree(er.er_data);
> +
> +             return error;

Whitespace damage.

> +int gfs2_acl_chmod(struct gfs2_inode *ip, struct iattr *attr)
> +{
> +     struct posix_acl *acl = NULL;
> +     struct gfs2_ea_location el;
> +     char *data;
> +     unsigned int len;
> +     int error;
> +
> +     error = acl_get(ip, ACL_ACCESS, &acl, &el, &data, &len);
> +     if (error)
> +             return error;
> +     if (!acl)
> +             return gfs2_setattr_simple(ip, attr);
> +
> +     {
> +             struct posix_acl *clone = posix_acl_clone(acl, GFP_KERNEL);
> +             error = -ENOMEM;
> +             if (!clone)
> +                     goto out;
> +             gfs2_memory_add(clone);
> +             gfs2_memory_rm(acl);
> +             posix_acl_release(acl);
> +             acl = clone;
> +     }

Duplicated above.

> +static int ea_foreach(struct gfs2_inode *ip, ea_call_t ea_call, void *data)
> +{
> +     struct buffer_head *bh;
> +     int error;
> +
> +     error = gfs2_meta_read(ip->i_gl, ip->i_di.di_eattr,
> +                            DIO_START | DIO_WAIT, &bh);
> +     if (error)
> +             return error;
> +
> +     if (!(ip->i_di.di_flags & GFS2_DIF_EA_INDIRECT))
> +             error = ea_foreach_i(ip, bh, ea_call, data);

goto out here so you can drop the else branch below.

> +     else {
> +             struct buffer_head *eabh;
> +             uint64_t *eablk, *end;
> +
> +             if (gfs2_metatype_check(ip->i_sbd, bh, GFS2_METATYPE_IN)) {
> +                     error = -EIO;
> +                     goto out;
> +             }
> +
> +             eablk = (uint64_t *)(bh->b_data +
> +                                  sizeof(struct gfs2_meta_header));
> +             end = eablk + ip->i_sbd->sd_inptrs;
> +

> +static int ea_find_i(struct gfs2_inode *ip, struct buffer_head *bh,
> +                  struct gfs2_ea_header *ea, struct gfs2_ea_header *prev,
> +                  void *private)
> +{
> +     struct ea_find *ef = (struct ea_find *)private;
> +     struct gfs2_ea_request *er = ef->ef_er;
> +
> +     if (ea->ea_type == GFS2_EATYPE_UNUSED)
> +             return 0;
> +
> +     if (ea->ea_type == er->er_type) {
> +             if (ea->ea_name_len == er->er_name_len &&
> +                 !memcmp(GFS2_EA2NAME(ea), er->er_name, ea->ea_name_len)) {
> +                     struct gfs2_ea_location *el = ef->ef_el;
> +                     get_bh(bh);
> +                     el->el_bh = bh;
> +                     el->el_ea = ea;
> +                     el->el_prev = prev;
> +                     return 1;
> +             }
> +     }
> +
> +#if 0
> +     else if ((ip->i_di.di_flags & GFS2_DIF_EA_PACKED) &&
> +              er->er_type == GFS2_EATYPE_SYS)
> +             return 1;
> +#endif

Please drop commented out code.

> +static int ea_list_i(struct gfs2_inode *ip, struct buffer_head *bh,
> +                  struct gfs2_ea_header *ea, struct gfs2_ea_header *prev,
> +                  void *private)
> +{
> +     struct ea_list *ei = (struct ea_list *)private;

Please drop redundant cast.

> +static int ea_set_i(struct gfs2_inode *ip, struct gfs2_ea_request *er,
> +                 struct gfs2_ea_location *el)
> +{
> +     {
> +             struct ea_set es;
> +             int error;
> +
> +             memset(&es, 0, sizeof(struct ea_set));
> +             es.es_er = er;
> +             es.es_el = el;
> +
> +             error = ea_foreach(ip, ea_set_simple, &es);
> +             if (error > 0)
> +                     return 0;
> +             if (error)
> +                     return error;
> +     }
> +     {
> +             unsigned int blks = 2;
> +             if (!(ip->i_di.di_flags & GFS2_DIF_EA_INDIRECT))
> +                     blks++;
> +             if (GFS2_EAREQ_SIZE_STUFFED(er) > ip->i_sbd->sd_jbsize)
> +                     blks += DIV_RU(er->er_data_len,
> +                                    ip->i_sbd->sd_jbsize);
> +
> +             return ea_alloc_skeleton(ip, er, blks, ea_set_block, el);
> +     }

Please drop the extra braces.
