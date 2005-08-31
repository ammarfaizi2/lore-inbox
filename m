Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVHaM57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVHaM57 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVHaM57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:57:59 -0400
Received: from NS8.Sony.CO.JP ([137.153.0.33]:56047 "EHLO ns8.sony.co.jp")
	by vger.kernel.org with ESMTP id S964786AbVHaM56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:57:58 -0400
Message-ID: <4315A94E.3030901@sm.sony.co.jp>
Date: Wed, 31 Aug 2005 21:57:50 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #3
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>	 <874q979qdj.fsf@devron.myhome.or.jp> <43156963.8020203@sm.sony.co.jp> <84144f0205083103005b791f4d@mail.gmail.com>
In-Reply-To: <84144f0205083103005b791f4d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Pekka Enberg wrote:
> Hi,
> 
> On 8/31/05, Machida, Hiroyuki <machida@sm.sony.co.jp> wrote:
> 
>>+inline
>>+static int hint_allocate(struct inode *dir)
>>+{
>>+       loff_t *hints;
>>+       int err = 0;
>>+
>>+       if (!MSDOS_I(dir)->scan_hints) {
>>+               hints = kcalloc(FAT_SCAN_NWAY, sizeof(loff_t), GFP_KERNEL);
>>+               if (!hints)
>>+                       err = -ENOMEM;
> 
> 
> Better to bail out here as...
> 
> 
>>+
>>+               down(&MSDOS_I(dir)->scan_lock);
>>+               if (MSDOS_I(dir)->scan_hints)
>>+                       err = -EINVAL;
> 
> 
> ...you might overwrite -ENOMEM here masking the real problem.
> 

It's ok. If MSDOS_I(dir)->scan_hints isn't NULL, it's not error case.
We need just kfree(hints) and return 0.(Assuming  kfree() accepts NULL)
I think EINVAL confuse you.
> 
>>+               if (!err)
>>+                       MSDOS_I(dir)->scan_hints = hints;
>>+               up(&MSDOS_I(dir)->scan_lock);
>>+               if (err == -EINVAL) {
> 
> 
> Gotos would make error handling much cleaner.
> 
How about this ?

	if (!MSDOS_I(dir)->scan_hints) {
		hints  = kcalllo(....);

		down
		if (MSDOS_I(dir)->scan_hints) {
			up
			goto already_allocated;
		}
		if (hints)
			MSDOS_I(dir)->scan_hints = hints;
		up
	}
	return (hints == 0) ? -ENOMEM : 0;

already_allocated:
	kfree(hints); /* kfree accepts NULL */
	return 0;
		


> 
>>+inline
>>+static int hint_index_body(const unsigned char *name, int name_len, int check_null)
> 
> 
> Please consider calling this __hint_index() instead as per normal
> naming conventions.

Agree.

> 
>>+{
>>+       int i;
>>+       int val = 0;
>>+       unsigned char *p = (unsigned char *) name;
>>+       int id = current->pid;
>>+
>>+       for (i=0; i<name_len; i++) {
>>+               if (check_null && !*p) break;
> 
> 
> Please put break on separate line. You still have quite a few of these.

Agree

> 
> 
>>+               val = ((val << 1) & 0xfe) | ((val & 0x80) ? 1 : 0);
>>+               val ^= *p;
>>+               p ++;
>>+       }
>>+       id = ((id >> 8) & 0xf) ^ (id & 0xf);
>>+       val = (val << 1) | (id & 1);
>>+       return val & (FAT_SCAN_NWAY-1);
>>+}
> 
> 
>                               Pekka


-- 
Hiroyuki Machida		machida@sm.sony.co.jp		
SSW Dept. HENC, Sony Corp.
