Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSEVOLV>; Wed, 22 May 2002 10:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314454AbSEVOLU>; Wed, 22 May 2002 10:11:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:4112 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314451AbSEVOLR>;
	Wed, 22 May 2002 10:11:17 -0400
Message-ID: <3CEB9826.4070000@evision-ventures.com>
Date: Wed, 22 May 2002 15:07:50 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: jack@suse.cz, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.GSO.4.21.0205220801540.1068-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alexander Viro napisa?:
> 
> On Wed, 22 May 2002, Martin Dalecki wrote:
>  
> 
>>Or are are you going to reinvent just enother
>>case of /proc/ formatting compatibility problems?!
>>And the requirement to have /proc mounted for quoate usage?!
>>
>>I hate /proc/my/random/sandbox/becouse/I/dont/knwo/unix/and/have/no/taste
>>interfaces more and more...
>>
>>(PS. Hah! I found finally someone today who deserves flames! :-).)
> 
> 
> Gives the phrase "finding yourself" a whole new meaning, doesn't it?
> 
> Al, deeply PO'd by assorted cretinisms _not_ related to the kernel.
> Sigh...

Lokking at 2.5.17 I see the following:

-#define QUOTAFILENAME "quota"
-#define QUOTAGROUP "staff"


As usuall we can see what goes to /proc is apparently
random bulls*it as always. I love in esp. the assumption about
some group name on a system!
But it get's removed this time. So let's peer where
it get's reintroduced:

Ah... yes, patch-2.5.17, here it is:

+#ifdef CONFIG_PROC_FS
+static int read_stats(char *buffer, char **start, off_t offset, int count, int 
*eof, void *data)
+{
+ 
int len;
+ 
struct quota_format_type *actqf;
+
+ 
dqstats.allocated_dquots = nr_dquots;
+ 
dqstats.free_dquots = nr_free_dquots;
+
+ 
len = sprintf(buffer, "Version %u\n", __DQUOT_NUM_VERSION__);
+ 
len += sprintf(buffer + len, "Formats");
+ 
lock_kernel();
+ 
for (actqf = quota_formats; actqf; actqf = actqf->qf_next)
+ 
	len += sprintf(buffer + len, " %u", actqf->qf_fmt_id);
  	unlock_kernel();
- 
return ret;
+ 
len += sprintf(buffer + len, "\n%u %u %u %u %u %u %u %u\n",
+ 
		dqstats.lookups, dqstats.drops,
+ 
		dqstats.reads, dqstats.writes,
+ 
		dqstats.cache_hits, dqstats.allocated_dquots,
+ 
		dqstats.free_dquots, dqstats.syncs);
+
+ 
if (offset >= len) {
+ 
	*start = buffer;
+ 
	*eof = 1;
+ 
	return 0;
+ 
}
+ 
*start = buffer + offset;
+ 
if ((len -= offset) > count)
+ 
	return count;
+ 
*eof = 1;
+
+ 
return len;
+}
+#endif

What can we see in the above:

1. Those are first grade candidates for sysctl read-only entires, since they
    are system global statistics which should belong to /proc/sys/fs/
    We even have already fs.dquot-nr there! Why the hell don't put them
    alongside?

2. Typical string formating and value copy and termination
     problems inherent to string stuff...

3. The futile hope that tools using it will even bother to check the
    Version... gtop just *right today* showed that user space programmers
    won't care about it, so it gains us literally *nothing*.

If it where sysctl numbers they would just vanish beneath them if something
changed semantincally and they *would have no chance* to do it wrong.

