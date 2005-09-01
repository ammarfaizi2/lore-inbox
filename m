Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbVIAUAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbVIAUAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbVIAUAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:00:54 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:63127 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030341AbVIAUAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:00:49 -0400
Message-ID: <43175DEC.4000600@acm.org>
Date: Thu, 01 Sep 2005 15:00:44 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@ZenIV.linux.org.uk
Cc: Matt_Domsch@Dell.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][CFLART] ipmi procfs bogosity
References: <20050901064313.GB26264@ZenIV.linux.org.uk> <1125592902.27283.5.camel@i2.minyard.local> <20050901193201.GD26264@ZenIV.linux.org.uk>
In-Reply-To: <20050901193201.GD26264@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@ZenIV.linux.org.uk wrote:

>On Thu, Sep 01, 2005 at 11:41:42AM -0500, Corey Minyard wrote:
>  
>
>>Indeed, this function is badly written.  In rewriting, I couldn't find a
>>nice function for reading integers from userspace, and the proc_dointvec
>>stuff didn't seem terribly suitable.  So I wrote my own general
>>function, which I can move someplace else if someone likes.  Patch is
>>attached.  It should not affect correct usage of this file.
>>    
>>
>
>Eeeek...  Much, _much_ simpler approach would be to have
>
>	char buf[10];
>	if (count > 9)
>		return -EINVAL;
>	if (copy_from_user(buf, buffer, count))
>		return -EFAULT;
>	buf[count] = '\0';
>	/* use sscanf() or anything normal */
>
>Would that change behaviour in any cases you care about?
>  
>
Because then, for a general solution that avoids integer
perversion, you need something like:

    char         buf[10];
    char         *end;

    if (count > (sizeof(buf) - 1))
        return -EINVAL;
    if (copy_from_user(buf, buffer, count))
        return -EFAULT;
    buf[count] = '\0';
    newval = simple_strtoul(buf, &end, 0);
    if (buf == end)
        /* Empty string or first char not a number */
        return -EINVAL;
    if (*end && ! isspace(*end))
        /* Bogus number. */
        return -EINVAL;


To me, It's a lot nicer to do:

    rv = user_strtoul(....);
    if (rv < 0)
        return rv;

Plus the scanning function I wrote handles arbitrary leading and 
trailing space, etc.  Not a big deal, but a little nicer.

-Corey
