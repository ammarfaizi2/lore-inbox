Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbSJUUf6>; Mon, 21 Oct 2002 16:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbSJUUf5>; Mon, 21 Oct 2002 16:35:57 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:50500 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261638AbSJUUf0>; Mon, 21 Oct 2002 16:35:26 -0400
Date: Mon, 21 Oct 2002 13:49:37 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Christoph Hellwig <hch@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44: lkcd (8/9): dump compression files
In-Reply-To: <20021021165531.B14993@sgi.com>
Message-ID: <Pine.LNX.4.44.0210211348570.22662-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We'll correct these issues and re-post.

--Matt

On Mon, 21 Oct 2002, Christoph Hellwig wrote:
|>On Mon, Oct 21, 2002 at 03:16:03AM -0700, Matt D. Robinson wrote:
|>> +
|>> +/*
|>> + * -----------------------------------------------------------------------
|>> + *                       D E F I N I T I O N S
|>> + * -----------------------------------------------------------------------
|>> + */
|>> +#define DUMP_MODULE_NAME "dump_gzip"
|>> +#define DUMP_PRINTN(format, args...) \
|>> +	printk("%s: " format , DUMP_MODULE_NAME , ## args);
|>
|>Those two don't seem to be used at all.
|>
|>> +#define DUMP_PRINT(format, args...) \
|>> +	printk(format , ## args);
|>
|>Please just use printk directly.
|>
|>> +/* setup the gzip compression functionality */
|>> +static dump_compress_t dump_gzip_compression = {
|>> +	compress_type:	DUMP_COMPRESS_GZIP,
|>> +	compress_func:	dump_compress_gzip,
|>> +};
|>
|>This want C99-style initializes.
|>
|>> +
|>> +/*
|>> + * Name: dump_compress_gzip_init()
|>> + * Func: Initialize gzip as a compression mechanism.
|>> + */
|>> +int __init
|>> +dump_compress_gzip_init(void)
|>ould be static.
|>
|>
|>> +{
|>> +	deflate_workspace = vmalloc(zlib_deflate_workspacesize());
|>> +	if (!deflate_workspace) {
|>> +		DUMP_PRINT("Failed to alloc %d bytes for deflate workspace\n",
|>> +			zlib_deflate_workspacesize());
|>> +		return -ENOMEM;
|>> +	}
|>> +	dump_register_compression(&dump_gzip_compression);
|>> +	return (0);
|>> +}
|>> +
|>> +/*
|>> + * Name: dump_compress_gzip_cleanup()
|>> + * Func: Remove gzip as a compression mechanism.
|>> + */
|>> +void __exit
|>> +dump_compress_gzip_cleanup(void)
|>
|>Dito
|>
|>> +{
|>> +	vfree(deflate_workspace);
|>> +	dump_unregister_compression(DUMP_COMPRESS_GZIP);
|>> +}
|>> +
|>> +/* module initialization */
|>> +module_init(dump_compress_gzip_init);
|>> +module_exit(dump_compress_gzip_cleanup);
|>> +
|>> +#ifdef MODULE
|>> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,16))
|>> +MODULE_LICENSE("GPL");
|>> +#endif
|>> +#endif /* MODULE */
|>
|>Please remove the horrible ifdefs.  MODULE_AUTHOR and MODULE_DESCRIPTION
|>would be nice, btw..
|>
|>> +/*
|>> + * Name: dump_compress_rle()
|>> + * Func: Compress a DUMP_PAGE_SIZE (hardware) page down to something more reasonable,
|>> + *       if possible.  This is the same routine we use in IRIX.
|>> + */
|>
|>Reformat to fit an ANSI terminal?
|>
|>> +static int
|>> +dump_compress_rle(char *old, int oldsize, char *new, int newsize)
|>> +{
|>> +	int ri, wi, count = 0;
|>> +	u_char value = 0, cur_byte;
|>
|>u16
|>
|>> +/* setup the rle compression functionality */
|>> +static dump_compress_t dump_rle_compression = {
|>> +	compress_type:	DUMP_COMPRESS_RLE,
|>> +	compress_func:	dump_compress_rle,
|>> +};
|>
|>Again, C99-initializers.
|>
|>> +
|>> +/*
|>> + * Name: dump_compress_rle_init()
|>> + * Func: Initialize rle compression for dumping.
|>> + */
|>> +int __init
|>> +dump_compress_rle_init(void)
|>
|>Again static
|>
|>> +{
|>> +	dump_register_compression(&dump_rle_compression);
|>> +	return (0);
|>
|>Shouldn't dump_register_compression return æn error that
|>you should return?  Also return 0 instead of return (0)
|>
|>> +/*
|>> + * Name: dump_compress_rle_cleanup()
|>> + * Func: Remove rle compression for dumping.
|>> + */
|>> +void __exit
|>> +dump_compress_rle_cleanup(void)
|>> +{
|>
|>Static again.
|>
|>> +	dump_unregister_compression(DUMP_COMPRESS_RLE);
|>> +}
|>> +
|>> +/* module initialization */
|>> +module_init(dump_compress_rle_init);
|>> +module_exit(dump_compress_rle_cleanup);
|>> +
|>> +#ifdef MODULE
|>> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,16))
|>> +MODULE_LICENSE("GPL");
|>> +#endif
|>> +#endif /* MODULE */
|>
|>As above.
|>
|>Btw, any chance the actual algorithm could go into lib/?
|>

-- 

