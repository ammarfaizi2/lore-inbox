Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVGFNnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVGFNnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 09:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVGFNnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 09:43:03 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:24702 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262125AbVGFJzv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 05:55:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=So4o8BQmwtqhRD4idQq79UlHyWPrr7ZRy1FeqgPCrBVtH0ZCvdtnXmxzGHpunqwNJOpPwthTjUCfpN8F4D7dtzNCGfGywPbGCOxKCQhY+tVHJ7ZbieXGPHJhBi7fSqx6zuaqW41DB0uzzbvjhWy33rGS6DucSdlmO32FALd2sfA=
Message-ID: <84144f020507060255638ba0c6@mail.gmail.com>
Date: Wed, 6 Jul 2005 12:55:48 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [45/48] Suspend2 2.1.9.8 for 2.6.12: 621-swsusp-tidy.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <11206164441379@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <11206164441379@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 622-swapwriter.patch-old/kernel/power/suspend_swap.c 622-swapwriter.patch-new/kernel/power/suspend_swap.c
> --- 622-swapwriter.patch-old/kernel/power/suspend_swap.c        1970-01-01 10:00:00.000000000 +1000
> +++ 622-swapwriter.patch-new/kernel/power/suspend_swap.c        2005-07-05 23:48:59.000000000 +1000
> +/*
> + * ---------------------------------------------------------------
> + *
> + *     Internal Data Structures
> + *
> + * ---------------------------------------------------------------
> + */

Can we please tone down this banner?

> +struct {
> +       /* Extent chains for swap & blocks */
> +       struct extentchain swapextents;
> +       struct extentchain block_chain[MAX_SWAPFILES];
> +
> +       /* Location of start of pagedir 1 */
> +       struct extent * pd1start_block_extent;
> +       int pd1start_chain;
> +       int pd1start_extent_number;
> +       unsigned long pd1start_block_offset;
> +
> +       /* Devices used for swap */
> +       dev_t swapdevs[MAX_SWAPFILES];
> +       char blocksizes[MAX_SWAPFILES];
> +
> +} header_data;
> +
> +static dev_t header_device = 0;
> +static struct block_device * header_block_device = NULL;
> +static int headerblocksize = PAGE_SIZE;
> +static int headerblock;
> +
> +/* For swapfile automatically swapon/off'd. */
> +static char swapfilename[256] = "";

<linux/suspend.h> already has SWAP_FILENAME_MAXLENGTH. Use that.

> +extern asmlinkage long sys_swapon(const char * specialfile, int swap_flags);
> +extern asmlinkage long sys_swapoff(const char * specialfile);
> +static int suspend_swapon_status = 0;
> +
> +/*
> + * ---------------------------------------------------------------
> + *
> + *     Current state.
> + *
> + * ---------------------------------------------------------------
> + */

Could we please tone down this banner?

> +
> +/* Which pagedir are we saving/reloading? Needed so we can know whether to
> + * remember the last swap entry used at the end of writing pageset2, and
> + * get that location when saving or reloading pageset1.*/
> +static int current_stream = 0;

No need to set to zero. The compiler will do it for you.

> +
> +/* Pointer to current swap entry being loaded/saved. */
> +static struct extent * currentblockextent = NULL;
> +static unsigned long currentblockoffset = 0;
> +static int currentblockchain = 0;
> +static int currentblocksperpage = 0;
> +
> +/* Header Page Information */
> +static int header_pages_allocated = 0;
> +static struct submit_params * first_header_submit_info = NULL,
> + * last_header_submit_info = NULL, * current_header_submit_info = NULL;

Ditto. (applies to NULL as well)

> +static void get_header_params(struct submit_params * headerpage)
> +{
> +       swp_entry_t entry = headerpage->swap_address;
> +       int swapfilenum = swp_type(entry);
> +       unsigned long offset = swp_offset(entry);
> +       struct swap_info_struct * sis = get_swap_info_struct(swapfilenum);
> +       sector_t sector = map_swap_page(sis, offset);
> +
> +       headerpage->dev = sis->bdev,
> +       headerpage->block[0] = sector;
> +       //headerpage->blocks_used = 1;

Please drop commented out code.

> +static int try_to_open_resume_device(void)
> +{
> +       resume_block_device = open_by_devnum(resume_device, FMODE_READ);
> +
> +       if (IS_ERR(resume_block_device) || (!resume_block_device))

The second set of parenthesis are redundant.

> +       /*
> +        * Put bdev of suspend header in last byte of swap header
> +        * (unsigned short)
> +        */
> +       if (type > 11) {
> +               dev_t * header_ptr = (dev_t *) &header[1];
> +               unsigned char * headerblocksize_ptr =
> +                       (unsigned char *) &header[5];
> +               unsigned long * headerblock_ptr = (unsigned long *) &header[6];
> +               header_device = *header_ptr;
> +               /*
> +                * We are now using the highest bit of the char to indicate
> +                * whether we have attempted to resume from this image before.
> +                */
> +               clear_suspend_state(SUSPEND_RESUMED_BEFORE);
> +               if (((int) *headerblocksize_ptr) & 0x80)
> +                       set_suspend_state(SUSPEND_RESUMED_BEFORE);
> +               headerblocksize = 512 * (((int) *headerblocksize_ptr) & 0xf);

Hardcoded sector size?

> +
> +       /* Restore device info */
> +       for (i = 0; i < MAX_SWAPFILES; i++) {
> +               dev_t thisdevice = header_data.swapdevs[i];
> +
> +               swap_info[i].bdev = NULL;
> +
> +               if (!thisdevice)
> +                       continue;
> +
> +               if (thisdevice == resume_device) {
> +                       swap_info[i].bdev = resume_block_device;
> +                       /* Mark as used so the device doesn't get suspended. */
> +                       swap_info[i].swap_file = (struct file *) 0xffffff;

Please use constants instead of magic numbers.

> +static int swapwriter_write_init(int stream_number)
> +{
> +       current_stream = stream_number;
> +
> +       if (current_stream == 1) {
> +               currentblockextent = header_data.pd1start_block_extent;
> +               currentblockoffset = header_data.pd1start_block_offset;
> +               currentblockchain = header_data.pd1start_chain;
> +       } else

See below.

> +               for (currentblockchain = 0; currentblockchain < MAX_SWAPFILES;
> +                               currentblockchain++)
> +                       if (header_data.block_chain[currentblockchain].first) {
> +                               currentblockextent =
> +                                       header_data.
> +                                        block_chain[currentblockchain].first;
> +                               currentblockoffset = currentblockextent->minimum;
> +                               break;
> +                       }

Braces would make sense here.


> +
> +       currentblocksperpage = get_blocks_per_page(currentblockchain);
> +
> +       suspend_bio_ops.reset_io_stats();
> +
> +       return 0;
> +}
> +
> +static int swapwriter_write_chunk(struct page * buffer_page)
> +{
> +       int i;
> +       struct submit_params submit_params;
> +
> +       if (TEST_ACTION_STATE(SUSPEND_TEST_FILTER_SPEED))
> +               return 0;
> +
> +       if (currentblockchain == MAX_SWAPFILES) {
> +               printk("Error! We have run out of blocks for writing data.\n");
> +               return -ENOSPC;
> +       }
> +
> +       if (!currentblockextent) {
> +               do {
> +                       currentblockchain++;
> +               } while ((currentblockchain < MAX_SWAPFILES) &&
> +                  (!header_data.block_chain[currentblockchain].first));
> +
> +               /* We can validly not have a new blockextent. We
> +                * might be compressing data and the user was
> +                * too optimistic in setting the compression
> +                * ratio or we're just copying the pageset. */
> +
> +               if (currentblockchain == MAX_SWAPFILES) {
> +                       printk("Argh. Ran out of block chains.\n");
> +                       return -ENOSPC;
> +               }
> +
> +               currentblockextent =
> +                header_data.block_chain[currentblockchain].first;
> +               currentblockoffset = currentblockextent->minimum;
> +               currentblocksperpage = get_blocks_per_page(currentblockchain);
> +       }
> +
> +       submit_params.readahead_index = -1;
> +       submit_params.page = buffer_page;
> +       submit_params.dev = swap_info[currentblockchain].bdev;
> +
> +       /* Get the blocks */
> +       submit_params.block[0] = currentblockoffset;
> +       for (i = 0; i < currentblocksperpage; i++)
> +               GET_EXTENT_NEXT(currentblockextent, currentblockoffset);
> +
> +       suspend_bio_ops.submit_io(WRITE, &submit_params, 0);
> +
> +       check_shift_keys(0, NULL);
> +
> +       return 0;
> +}
> +
> +static int swapwriter_write_cleanup(void)
> +{
> +       if (current_stream == 2) {

Where did that magic number two come from?

> +               header_data.pd1start_block_extent = currentblockextent;
> +               header_data.pd1start_block_offset = currentblockoffset;
> +               header_data.pd1start_chain = currentblockchain;
> +       }
> +
> +       suspend_bio_ops.finish_all_io();
> +
> +       suspend_bio_ops.check_io_stats();
> +
> +       return 0;
> +}
> +
> +static int swapwriter_read_init(int stream_number)
> +{
> +       current_stream = stream_number;
> +
> +       if (current_stream == 1) {

Ditto.

> +static int swapwriter_parse_image_location(char * commandline, int only_writer)
> +{
> +       char *thischar, *devstart = NULL, *colon = NULL, *at_symbol = NULL;
> +       union p_diskpage diskpage;
> +       int signature_found, result = -EINVAL, temp_result;
> +
> +       if (strncmp(commandline, "swap:", 5)) {
> +               if (!only_writer)
> +                       return 1;
> +       } else
> +               commandline += 5;
> +
> +       devstart = thischar = commandline;
> +       while ((*thischar != ':') && (*thischar != '@') &&
> +               ((thischar - commandline) < 250) && (*thischar))

What's the magic 250 here?

> +               thischar++;
> +
> +       if (*thischar == ':') {
> +               colon = thischar;
> +               *colon = 0;
> +               thischar++;
> +       }
> +
> +       while ((*thischar != '@') && ((thischar - commandline) < 250) && (*thischar))

And here?

> +               thischar++;
> +
> +       if (*thischar == '@') {
> +               at_symbol = thischar;
> +               *at_symbol = 0;
> +       }
> +
> +       if (colon)
> +               resume_firstblock = (int) simple_strtoul(colon + 1, NULL, 0);
> +       else
> +               resume_firstblock = 0;
> +
> +       if (at_symbol) {
> +               resume_firstblocksize = (int) simple_strtoul(at_symbol + 1, NULL, 0);
> +               if (resume_firstblocksize & 0x1FF)
> +                       printk("Swapwriter: Blocksizes are usually a multiple of 512. Don't expect this to work!\n");

Then why do we allow it?
