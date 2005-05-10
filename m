Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVEKAA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVEKAA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 20:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVEKAA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 20:00:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:41193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261848AbVEJX6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 19:58:55 -0400
Date: Tue, 10 May 2005 16:59:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, abhay_salunke@dell.com, matt_domsch@dell.com,
       Greg KH <greg@kroah.com>
Subject: Re: [patch 2.6.12-rc3] dell_rbu: New Dell BIOS update driver
Message-Id: <20050510165925.271d7967.akpm@osdl.org>
In-Reply-To: <20050510220520.GA30741@littleblue.us.dell.com>
References: <20050510220520.GA30741@littleblue.us.dell.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abhay Salunke <Abhay_Salunke@dell.com> wrote:
>
> The dell_rbu driver is required for updating BIOS on DELL servers and client
> systems. The driver lets a user application download the BIOS image in to
> contiguous physical memory pages; the driver exposes the memory via sysfs
> filesystem. The update mechanism basically has two approcahes; one by
> allocating contiguous physical memory and the second approach is by allocating
> small chunks of contiguous physical memory.
> 
> The patch file is attached to this mail.

Greg, could you please review the sysfs usage?

> --- linux-2.6.11.8.ORIG/Documentation/DELL_RBU.txt	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.11.8/Documentation/DELL_RBU.txt	2005-05-09 16:34:47.477703152 -0500

2.6.11.8 is very old in kernel terms.  It's OK for this patch because it's
pretty standalone.  But in general, please raise patches against
contemporary kernels.  2.6.12-rc4 would be appropriate at present.

> +
> +#define BIT(x)	(1UL << ((x)%BITS_PER_LONG))

This is used only for:

+               rbu_data.image_update_buffer_size = BIT(ordernum) * PAGE_SIZE;

Please remove BIT() and just do

+               rbu_data.image_update_buffer_size = PAGE_SIZE << ordernum;

> +
> +static struct {

Some gcc's don't like anonymous structs (I think?).  Still, it would be
more conventional to give this guy a name.

> +	void *image_update_buffer;
> +	unsigned long image_update_buffer_size;
> +	unsigned long bios_image_size;
> +	unsigned long image_update_order_number;
> +	spinlock_t lock;
> +	unsigned long packet_read_count;
> +	unsigned long packet_write_count;
> +	unsigned long num_packets;
> +	unsigned long packetsize;
> +}rbu_data ;

Make this

   } rbu_data;

> +struct packet_data{

   struct packet_data {

> +       struct list_head list;
> +       size_t length;
> +       void *rbu_data;

Should that be

	struct rbu_data *rbu_data;

?

> +
> +static decl_subsys(rbu,&ktype_rbu,NULL);
> +

   static decl_subsys(rbu, &ktype_rbu, NULL);

> +static void init_rbu_lock(void *plock)
> +{
> +	spin_lock_init((spinlock_t *)plock);
> +}
> +
> +static void lock_rbu_access(void *plock)
> +{
> +	spin_lock((spinlock_t *)plock);
> +}
> +
> +static void unlock_rbu_access(void *plock)
> +{
> +	spin_unlock((spinlock_t *)plock);
> +}

Remove these and simply open-code the spinlock functions.

> +void init_packet_head(void)
> +{
> +	INIT_LIST_HEAD((struct list_head *)&packet_data_head);

OK, in lots of places the patch typecasts packet_data_head to a list_head,
then does list_head operations on it, relying on the fact that
packet_data.list is the first element.  Very weird.

Please replace all those with (for example)

	INIT_LIST_HEAD(&packet_data_head.list);

> +static int fill_last_packet(void *data, size_t length)
> +{
> +	struct list_head *ptemp_list;
> +	struct packet_data *ppacket = NULL;
> +	int packet_count = 0;
> +	
> +	pr_debug("fill_last_packet: entry \n");
> +
> +	/* check if we have any packets */
> +	if (0 == rbu_data.num_packets){

I know that some people like the `if (constant == variable)' thing to pick
up "= instead of ==" typos.  But gcc does warn about that mistake anyway,
and I think most people find the above construct to be artificial, and
harder to read.  Would prefer that all these be swapped around please.

Would also prefer a space before the '{'!


> +	ptemp_list = ((struct list_head *)&packet_data_head)->next;

Use packet_head_data.list

> +	
> +	while(--packet_count)
> +	{

	while (--packet_count) {

> +	if ((rbu_data.packet_write_count + length) >  rbu_data.packetsize) {

                                                    ^^

> +		printk(KERN_WARNING"fill_last_packet: packet size data overrun\n");

                                   ^ space here

> +*/
> +static void *get_free_pages_limited(unsigned long size,
> +									int *ordernum,
> +									unsigned long limit)

Wild whitespace here?

> +{
> +	unsigned long ImgBufPhysAddr;

Please stick with lower case and underscores in identifiers.

> +	void *pbuf = NULL;
> +
> +	*ordernum = get_order(size);
> +	/* check if we are not getting a very large file 
> +	This can happen as a user error in entering the file size */

The comment layout is a bit odd.

	/*
	 * Check if we are not getting a very large file.  This can happen
	 * as a user error in entering the file size.
	 */

> +	if (*ordernum == BITS_PER_LONG){

                                       ^ space

> +		/* The incoming size is very large */
> +		pr_debug("get_free_pages_limited: Incoming size is very large\n");
> +		return NULL;
> +	}
> +	
> +	/* try allocating a new buffer to fit the request */
> +    pbuf =(unsigned char *)__get_free_pages(GFP_KERNEL, *ordernum);
> +
> +	if (pbuf != NULL) {
> +		/* check if the image is with in limits */
> +		ImgBufPhysAddr = (unsigned long)virt_to_phys((void *)pbuf);
> +		
> +		if ((limit != 0) &&
> +			((ImgBufPhysAddr + size) > limit)) {
> +			
> +			pr_debug("Got memory above 4GB range, free this and try with DMA memory\n");

The indenting has gone funny here.

> +			
> +			/* free this memory as we need it with in 4GB range */
> +			free_pages ((unsigned long)pbuf, *ordernum);
> +			
> +			/* try allocating a new buffer from the GFP_DMA range 
> +			   as it is with in 16MB range.*/
> +			pbuf =(unsigned char *)__get_free_pages(GFP_DMA, *ordernum);
> +			
> +			if (pbuf == NULL)
> +				pr_debug("Failed to get memory of size %ld using GFP_DMA\n", size);
> +		}
> +	}
> +	return pbuf;
> +}

What architecture is this code designed for?  On x86 a GFP_KERNEL
allocation will never return highmem.  I guess x86_64?

I assume this code is here because the x86_64 BIOS will only access the
lower 4GB?  If so, a comment to that extent would be useful.

Sometime I expect that x86_64 will gain a new zone, GFP_DMA32 which will be
guaranteed to return memory below he 4GB point.  When that happens, this
driver should be converted to use it.

> +static int create_packet(size_t length)
> +{
> +	struct packet_data *newpacket;
> +	int ordernum =0;

                      ^ space

> +	newpacket = kmalloc(sizeof(struct packet_data) , GFP_KERNEL);
                                                      ^

> +	if(newpacket == NULL){

          ^                  ^ spaces

> +	if(newpacket->rbu_data == NULL){

Ditto.  Lots of places.

> +		printk(KERN_WARNING"create_packet: failed to allocate new packet\n");
> +		return -ENOMEM;
> +	}
> +
> +	newpacket->ordernum = ordernum;
> +
> +	++rbu_data.num_packets;
> +	/* initialize the newly created packet headers */
> +	INIT_LIST_HEAD(&newpacket->list);
> +	/* add this packet to the link list */
> +	list_add_tail(&newpacket->list, (struct list_head *)&packet_data_head);

Does this list not need locking?

Use packet_data_head.list, remove the typecast.

> +	/* packets are of fixed sizes so initialize the length to rbu_data.packetsize*/

Try to fit the code into an 80-column xterm, please.

> +/*
> + do_packet_read :
> + This is a helper function which reads the packet data of the 
> + current list.
> + data: is the incoming buffer
> + ptemp_list: points to the incoming list item
> + length: is the length of the free space in the buffer.
> + bytes_read: is the total number of bytes read already from 
> + the packet list
> + list_read_count: is the counter to keep track of the number 
> + of bytes read out of each packet.
> +*/
> +int do_packet_read(char * data, struct list_head *ptemp_list, int length,

It's (a bit) more conventional to not have the space after the `*' when
declaring pointers:

		char *data

Here, both styles are used in the same line!

> +{
> +	void *ptemp_buf;
> +	struct packet_data *newpacket = NULL;

This initialisation is unneeded.

> +	int bytes_copied = 0;
> +	void *pDest = data;

lowercase and underscore in identifiers

> +	int j = 0;
> +
> +	newpacket = list_entry(ptemp_list,struct packet_data, list);
> +	*list_read_count += newpacket->length;
> +
> +	if (*list_read_count > bytes_read) {
> +		/* point to the start of unread data */
> +		j = newpacket->length - (*list_read_count - bytes_read);
> +		/* point to the offset in the packet buffer*/
> +		ptemp_buf = (u8 *)newpacket->rbu_data + j;

The cast is actually unneeded - gcc will treat void* as a "pointer to
something which has sizeof==1" when performing such arithmetic.  I believe
this is a gcc extension.

> +		/* check if there is enough room in the 
> +		incoming buffer*/

Odd comment layout.

> +/*
> + packet_read_list:
> + This function reads the data out of the packet link list.
> + It will read data from multiple packets depending upon the 
> + size of the incoming buffer.
> + data: is the incoming buffer pointer
> + *pread_length: is the length of the incoming buffer. At return 
> + this value is adjusted to the actual size of the data read.
> +*/
> +static int packet_read_list(char *data, size_t *pread_length)
> +{
> +	struct list_head *ptemp_list;
> +	int temp_count = 0;
> +	int bytes_copied = 0;
> +	int bytes_read = 0;
> +	int remaining_bytes =0;
> +	char *pDest = data;

Are all these initialisations actually needed?

> +	ptemp_list = ((struct list_head *)&packet_data_head)->next;

packet_data_head.next

> +	while(!list_empty(ptemp_list))
> +	{

	while (!list_empty(ptemp_list)) {

> +static void packet_empty_list(void)
> +{
> +	struct list_head *ptemp_list;
> +	struct list_head *pnext_list;
> +	struct packet_data *newpacket;
> +
> +	ptemp_list = ((struct list_head *)&packet_data_head)->next;

ditto

> +	while(!list_empty(ptemp_list))
> +	{

ditto

I think list_for_each_entry_safe() would work here.

> +/*
> + img_update_free:
> + Frees the buffer allocated for storing BIOS image
> + Always called with lock held
> +*/
> +static void img_update_free( void)

   static void img_update_free(void)

> +{
> +	if (rbu_data.image_update_buffer == NULL)
> +		return;

Can this happen?

> +	/* zero out this buffer before freeing it */
> +	memset(rbu_data.image_update_buffer, 0, rbu_data.image_update_buffer_size);
> +	/* unlock as free_pages might sleep */
> +	unlock_rbu_access(&rbu_data.lock);
> + 	free_pages((unsigned long)rbu_data.image_update_buffer, 
> +		rbu_data.image_update_order_number);
> +	lock_rbu_access(&rbu_data.lock);

free_pages() will never sleep.

> +	rbu_data.image_update_buffer = NULL;
> +	rbu_data.image_update_buffer_size = 0;
> +	rbu_data.bios_image_size = 0;
> +}

Are these assignments needed?

> +static int img_update_realloc(unsigned long size)
> +{
> +	unsigned char *image_update_buffer = NULL;
> +	unsigned long rc;
> +	int ordernum =0;
> +
> +
> +	/* check if the buffer of sufficient size has been already allocated */
> +    if (rbu_data.image_update_buffer_size >= size) {
> +		/* check for corruption */
> +		if ((size != 0) && (rbu_data.image_update_buffer == NULL)) {
> +			pr_debug("img_update_realloc: corruption check failed\n");
> +			return -ENOMEM;

ENOMEM seems to be the wrong error to return here.

> +		}
> +		/* we have a valid pre-allocated buffer with sufficient size */
> +		return 0;
> +    }
> +
> +	/* free any previously allocated buffer */
> +	img_update_free();
> +
> +	/* This has already been called as locked so we can now unlock 
> +	and proceed to calling get_free_pages_limited as this function
> +	can sleep*/
> +	unlock_rbu_access(&rbu_data.lock);
> +
> +	image_update_buffer = (unsigned char *)get_free_pages_limited(size,

get_free_pages_limited() returns void*, so no typecast is needed.

> +		&ordernum,
> +		BIOS_SCAN_LIMIT);
> +	
> +	/* acquire the semaphore again */

It's actually a spinlock, not a semaphore.

> +	lock_rbu_access(&rbu_data.lock);
> +
> +	if (image_update_buffer != NULL) {
> +		/* store address for the new buffer */
> +		rbu_data.image_update_buffer = image_update_buffer;
> +		/* adjust allocated size */
> +		rbu_data.image_update_buffer_size = BIT(ordernum) * PAGE_SIZE;
> +		/* save the current order number */
> +		rbu_data.image_update_order_number = ordernum;
> +		/* initialize the new buffer data to 0 */
> +		memset(rbu_data.image_update_buffer,0, rbu_data.image_update_buffer_size);
> +		pr_debug("img_update_realloc: success\n");
> +		/* success */
> +		rc = 0; 
> +	} else {
> +		pr_debug("Not enough memory for image update:order number = %d"
> +			",size = %ld\n",ordernum, size);
> +		rc = -ENOMEM;
> +	}
> +
> +	return rc;
> +} /* img_update_realloc */

The comment over img_update_realloc() should mention that it returns with
the lock held.

> +
> +/*
> + read_packet_data_size:
> + Returns the size of an RBU packet; if no packets present returns 0
> +*/
> +static ssize_t read_packet_data_size(struct kobject *kobj, char *buffer, 
> +								  loff_t pos, size_t count)
> +{
> +	unsigned int size = 0;
> +	if (pos == 0) {
> +		lock_rbu_access(&rbu_data.lock);
> +		size = sprintf(buffer, "%lu\n", rbu_data.packetsize);
> +		unlock_rbu_access(&rbu_data.lock);

The locking here is meaningless.  rbu_data.packetsize can change any time
before or after the read.


> +	}
> +	return size;
> +} 
> +
> +/*
> + write_packet_data_size:
> + Writes the RBU data size supplied by the user, if the 
> + data size supplied is non zero number, this function 
> + records the packet size for any packet allocations.
> + If a byte size of zero is supplied this function will free
> + the previously allocated packets.
> +*/
> +static ssize_t write_packet_data_size(struct kobject *kobj, char *buffer, 
> +								   loff_t pos, size_t count)

80-cols.

> +static ssize_t read_rbu_data_size(struct kobject *kobj, char *buffer, 
> +								  loff_t pos, size_t count)

ditto.

> +{
> +	unsigned int size = 0;
> +	if (pos == 0) {
> +		lock_rbu_access(&rbu_data.lock);
> +		size = sprintf(buffer, "%lu\n", rbu_data.bios_image_size);
> +		unlock_rbu_access(&rbu_data.lock);

Unneeded or incorrect locking?

> +*/
> +static ssize_t write_rbu_data_size(struct kobject *kobj, char *buffer, 
> +								   loff_t pos, size_t count)

80-cols?

> +static ssize_t read_rbu_data(struct kobject *kobj, char *buffer, 
> +							 loff_t pos, size_t count)
> +{
> +	unsigned char *ptemp = NULL;
> +	int retVal =0;
> +	int bytes_left = 0;
> +	int data_length = 0;

Unneeded initialisations.  Please review all the code for that.

s/retVal/retval/

> +	data_length = ((bytes_left > count) ? count : bytes_left);

max()?

> +	ptemp = (char *)rbu_data.image_update_buffer;

unneeded typecast

> +	memcpy(buffer, (char *)(ptemp + pos), data_length);

unneeded typecast

> +	if ( pos > imagesize ) {

Quite a mix of coding styles in this patch!

> +	data_length = ((bytes_left > count) ? count : bytes_left);

max()

> +	if ((retVal = packet_read_list(ptempBuf, &data_length)) < 0)
> +		goto read_rbu_data_exit;
> +
> +	if ((pos + count) > imagesize) {
> +		rbu_data.packet_read_count = 0;
> +		/* this was the last copy */
> +		retVal = bytes_left;
> +	}
> +	else 
> +		retVal = count;
> +	

	} else {
		retVal = count;
	}

(opinions differ...)

> +	sysfs_create_bin_file(&rbu_subsys.kset.kobj, &rbudata_attr );
> +	sysfs_create_bin_file(&rbu_subsys.kset.kobj, &rbudatasize_attr );
> +	sysfs_create_bin_file(&rbu_subsys.kset.kobj, &packetdatasize_attr );
> +	sysfs_create_bin_file(&rbu_subsys.kset.kobj, &packetdata_attr );
> +	sysfs_remove_bin_file(&rbu_subsys.kset.kobj, &rbudata_attr );
> +	sysfs_remove_bin_file(&rbu_subsys.kset.kobj, &rbudatasize_attr );
> +	sysfs_remove_bin_file(&rbu_subsys.kset.kobj, &packetdatasize_attr );
> +	sysfs_remove_bin_file(&rbu_subsys.kset.kobj, &packetdata_attr );

whitepsace

>  
> +config DELL_RBU
> +        bool "BIOS update support for DELL systems via sysfs"
> +        default n
> +        help
> +          Say Y if you want to have the option of updating the BIOS for your
> +	  DELL system. Note you need a supporting application to comunicate 
> +	  with the BIOS regardign the new image for the image update to 
> +	  take effect.
> +
> +	  See <file:Documentation/DELL_RBU.txt> for more details on the driver.
> +

Should this feature be available for all architectures, or only for X86 ||
X86_64?  (If it compiles OK for other architectures then I'd leave it
as-is, for coverage).

The patch seems to alternate between using hard tabs and using
eight-spaces.  Hard tabs are preferred.  Please hunt that down and fix it
up.

