Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289034AbSAFVHb>; Sun, 6 Jan 2002 16:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289033AbSAFVHV>; Sun, 6 Jan 2002 16:07:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25869 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289034AbSAFVHH>; Sun, 6 Jan 2002 16:07:07 -0500
Message-ID: <3C38BC6B.7090301@zytor.com>
Date: Sun, 06 Jan 2002 13:06:51 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Matt Dainty <matt@bodgit-n-scarper.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com> <200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once again, this shit does not belong in N drivers; it is core code.

	-hpa


Richard Gooch wrote:

> Matt Dainty writes:
> 
>>Please find attached a patch to add support for devfs to the i386 cpuid and
>>msr drivers. Not only that, but it fixes a problem with loading these
>>drivers as modules in that the exit hooks on the module never run, (simply
>>changing the function prototypes to include 'static' seems to fix this).
>>
>>Patch is against 2.4.17. SMP environment isn't tested, but I can't see any
>>reason why it wouldn't work...
>>
> 
> Looks mostly reasonable, except for:
> 
> 
>>-void __exit cpuid_exit(void)
>>+static void __exit cpuid_exit(void)
>> {
>>-  unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
>>+  int i;
>>+  devfs_handle_t parent;
>>+
>>+  for(i = 0; i < NR_CPUS; i++) {
>>+    parent = devfs_get_parent(devfs_handle[i]);
>>+    devfs_unregister(devfs_handle[i]);
>>+    if(devfs_get_first_child(parent) == NULL)
>>+      devfs_unregister(parent);
>>+  }
>>+  devfs_unregister_chrdev(CPUID_MAJOR, "cpu/%d/cpuid");
>> }
>>
> 
> There is no need to remove the parent /dev/cpu/%d directory, and in
> fact it's better not to. All you need is this simpler loop:
> 	for(i = 0; i < NR_CPUS; i++)
> 		devfs_unregister(devfs_handle[i]);
> 
> You do something similar in the MSR driver.
> 
> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca
> 


