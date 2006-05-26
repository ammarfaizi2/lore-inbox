Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbWEZGNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbWEZGNl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 02:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWEZGNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 02:13:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1440 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030508AbWEZGNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 02:13:40 -0400
Message-ID: <44769C8D.2090000@cs.wisc.edu>
Date: Fri, 26 May 2006 01:13:33 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Bryan Holty <lgeek@frontiernet.net>
CC: Dan Aloni <da-x@monatomic.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, brking@us.ibm.com,
       dror@xiv.co.il
Subject: Re: [PATCH] scsi: properly count the number of pages in scsi_req_map_sg()
References: <20060321083830.GA2364@localdomain> <44205162.8000504@cs.wisc.edu> <200603211448.54620.lgeek@frontiernet.net> <200603220635.40251.lgeek@frontiernet.net>
In-Reply-To: <200603220635.40251.lgeek@frontiernet.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Holty wrote:
> On Tuesday 21 March 2006 14:48, Bryan Holty wrote:
>> On Tuesday 21 March 2006 13:17, Mike Christie wrote:
>>> Bryan Holty wrote:
>>>> On Tuesday 21 March 2006 10:19, Dan Aloni wrote:
>>>>> On Tue, Mar 21, 2006 at 09:54:54AM -0600, James Bottomley wrote:
>>>>>> This is a good email to discuss on the scsi list:
>>>>>> linux-scsi@vger.kernel.org; whom I've added to the cc list.
>>>>>>
>>>>>> On Tue, 2006-03-21 at 10:38 +0200, Dan Aloni wrote:
>>>>>>> Improper calculation of the number of pages causes bio_alloc() to
>>>>>>> be called with nr_iovecs=0, and slab corruption later.
>>>>>>>
>>>>>>> For example, a simple scatterlist that fails: {(3644,452), (0, 60)},
>>>>>>> (offset, size). bufflen=512 => nr_pages=1 => breakage. The proper
>>>>>>> page count for this example is 2.
>>>>>> Such a scatterlist would likely violate the device's underlying
>>>>>> boundaries and is not legal ... there's supposed to be special code
>>>>>> checking the queue alignment and copying the bio to an aligned buffer
>>>>>> if the limits are violated.  Where are you generating these
>>>>>> scatterlists from?
>>>>> These scatterlists can be generated using the sg driver. Though I am
>>>>> actually running a customized version of the sg driver, it seems the
>>>>> conversion from a userspace array of sg_iovec_t to scatterlist stays
>>>>> the same and also applies to the original driver (see
>>>>> st_map_user_pages()).
>>>> Hello,
>>>>     I am seeing the same issue when using direct io with sg.  sg will
>>>> perform direct io on any date that is aligned with the devices
>>>> dma_align. The default for drivers that do not specify is 512.  sg
>>>> builds the scatter gather list from the user specified location,
>>>> offsetting the first entry in the list if not page aligned.  This is
>>>> the case that causes the improper allocation of "nr_iovec" in
>>>> scsi_req_map_sgand the later slab corruption.
>>>>
>>>>     I don't think it is necessary to calculate nr_pages from the entire
>>>> list. Only sgl[0] is allowed to have an offset, so we can calculate
>>>> from that as follows.
>>>> --- a/drivers/scsi/scsi_lib.c	2006-03-03 13:17:22.000000000 -0600
>>>> +++ b/drivers/scsi/scsi_lib.c	2006-03-21 11:36:39.389763804 -0600
>>>> @@ -368,12 +368,15 @@
>>>>  			   int nsegs, unsigned bufflen, gfp_t gfp)
>>>>  {
>>>>  	struct request_queue *q = rq->q;
>>>> -	int nr_pages = (bufflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
>>>> +	int nr_pages = 0;
>>>>  	unsigned int data_len = 0, len, bytes, off;
>>>>  	struct page *page;
>>>>  	struct bio *bio = NULL;
>>>>  	int i, err, nr_vecs = 0;
>>>> -
>>>> +
>>>> +	if (nsegs)
>>> you can drop that test
>>>
>>>> + 		nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
>>>> +
>>> I think we can do this without looping but I think this is broken. If we
>>> had a slight variant of Dan's example but we have a page and some change
>>> in the first entry {3644, 4548} and 0,60} in the last one, that would
>>> would only calculate two pages but we want three.
>>>
>>> I think we can have to calculate the first and last entries but the
>>> middle ones we can assume have no offset and lengths that are multiples
>>> of a page.
>> You are absolutely correct.
>> bufflen is not page masked and when added to the offset of the first entry,
>> will generate the correct nr_pages.
>>
>>     nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
>> ==
>>     nr_pages = ((bufflen & PAGE_MASK) + (PAGE_SIZE-1) + sgl[0].offset +
>> sgl[nsegs-1].length) >> PAGE_SHIFT;
>>
>> Either will calculate correctly.
>>
>> --
>>  Bryan Holty
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 
> Based on above, I think the most intuitive fix would be the offset addition of 
> the first entry to the initialization of nr_pages.  
> 
> Without this change, for instance, with 4K io's every sg io that is 
> dma_aligned for direct io, but not page aligned will cause slab corruption 
> and an oops
> 
> I am able to run a number of tests with sg that cause the boundary to be 
> crossed, and with this fix there is no slab corruption or data corruption.
> 
> Thanks Dan, I had been hunting for this for a couple of days!!
> 
> Thoughts??
> 
> Signed-off-by: Bryan Holty <lgeek@frontiernet.net>
> 
>  --- a/drivers/scsi/scsi_lib.c	2006-03-03 13:17:22.000000000 -0600
> +++ b/drivers/scsi/scsi_lib.c	2006-03-22 06:09:09.669599539 -0600
> @@ -368,7 +368,7 @@
>  			   int nsegs, unsigned bufflen, gfp_t gfp)
>  {
>  	struct request_queue *q = rq->q;
> -	int nr_pages = (bufflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	int nr_pages = (bufflen + sgl[0].offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	unsigned int data_len = 0, len, bytes, off;
>  	struct page *page;
>  	struct bio *bio = NULL;
> --


Was this patch ok? I was looking at some other problem and noticed this
was not merged. The original calculation that I did in the code is
wrong. I thought the calculation in this patch was correct, but I have
showed that my math skills are lacking so I may be wrong.
