Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSIDU1I>; Wed, 4 Sep 2002 16:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSIDU1I>; Wed, 4 Sep 2002 16:27:08 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:49932 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S315437AbSIDU1H>; Wed, 4 Sep 2002 16:27:07 -0400
Message-ID: <3D766DA8.9030207@namesys.com>
Date: Thu, 05 Sep 2002 00:31:36 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: Tomas Szepe <szepe@pinerecords.com>, "David S. Miller" <davem@redhat.com>,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       aurora-sparc-devel@linuxpower.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com, Oleg Drokin <green@namesys.com>
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
References: <200209042018.g84KI6612079@shaggy.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:

>>>   Against 2.4.20-pre5 - fix up the type of nlink_t. This makes jfs and
>>>   reiserfs stop complaining about comparisons always turning up false
>>>   due to limited range of data type.
>>>
>>>If you change this, you change the types exported to userspace
>>>which will break everything.
>>>      
>>>
>>Right.  Here's a corresponding reiserfs/jfs fix, then.  I've checked the
>>constants aren't used for anything else except nlink overflow alerts.
>>    
>>
>
>I don't like this fix.  I know 32767 is a lot of links, but I don't like
>artificially lowering a limit like this just because one architecture
>defines nlink_t incorrectly.  I'd rather get rid of the compiler warnings
>with a cast in the few places the limit is checked, even though that is
>a little bit ugly.
>
>  
>
>>diff -urN linux-2.4.20-pre5/fs/jfs/jfs_filsys.h linux-2.4.20-pre5.n/fs/jfs/jfs_filsys.h
>>--- linux-2.4.20-pre5/fs/jfs/jfs_filsys.h	2002-09-01 11:31:44.000000000 +0200
>>+++ linux-2.4.20-pre5.n/fs/jfs/jfs_filsys.h	2002-09-01 11:30:13.000000000 +0200
>>@@ -125,7 +125,8 @@
>> #define MAXBLOCKSIZE		4096
>> #define	MAXFILESIZE		((s64)1 << 52)
>>
>>-#define JFS_LINK_MAX		65535	/* nlink_t is unsigned short */
>>+/* the shortest nlink_t there is is sparc's signed short */
>>+#define JFS_LINK_MAX		32767
>>
>> /* Minimum number of bytes supported for a JFS partition */
>> #define MINJFS			(0x1000000)
>>diff -urN linux-2.4.20-pre5/include/linux/reiserfs_fs.h linux-2.4.20-pre5.n/include/linux/reiserfs_fs.h
>>--- linux-2.4.20-pre5/include/linux/reiserfs_fs.h	2002-09-01 11:31:45.000000000 +0200
>>+++ linux-2.4.20-pre5.n/include/linux/reiserfs_fs.h	2002-09-01 11:23:30.000000000 +0200
>>@@ -1185,10 +1185,12 @@
>> #define MAX_B_NUM  MAX_UL_INT
>> #define MAX_FC_NUM MAX_US_INT
>>
>>-
>>-/* the purpose is to detect overflow of an unsigned short */
>>-#define REISERFS_LINK_MAX (MAX_US_INT - 1000)
>>-
>>+/* the original purpose was to detect a possible overflow
>>+ * of an unsigned short nlink_t. However, there are archs
>>+ * that only provide a signed short nlink_t, so this will
>>+ * have to start ringing a wee bit earlier.
>>+ */
>>+#define REISERFS_LINK_MAX (0x7fff - 1000)
>>
>> /* The following defines are used in reiserfs_insert_item and reiserfs_append_item  */
>> #define REISERFS_KERNEL_MEM		0	/* reiserfs kernel memory mode	*/
>>    
>>
>
>Thanks,
>Shaggy
>
>  
>
I think you are sort of right.  You are right to dislike this patch for 
the reasons you state.  The proper fix should be to make the result of 
the limit computation be accurately architecture specific.   I wasn't 
paying enough attention --- hardcoding

0x7fff - 1000 

is ugly.  We need to find some appropriate #define to subtract 1000 from.

Green, please scan the code for the magic constant to compute from, and 
code something unless Dave or someone does it before you.

