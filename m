Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263588AbUESByq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbUESByq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 21:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbUESByq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 21:54:46 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:22730 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S263588AbUESByn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 21:54:43 -0400
Message-ID: <40AABE49.1050401@myrealbox.com>
Date: Tue, 18 May 2004 18:54:17 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andy Lutomirski <luto@myrealbox.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] scaled-back caps, take 4
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40A4F163.6090802@stanford.edu> <20040514110752.U21045@build.pdx.osdl.net> <200405141548.05106.luto@myrealbox.com> <20040517231912.H21045@build.pdx.osdl.net> <40A9D356.6060807@stanford.edu> <20040518182751.J21045@build.pdx.osdl.net>
In-Reply-To: <20040518182751.J21045@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

> * Andy Lutomirski (luto@stanford.edu) wrote:
> 
>>Chris Wright wrote:
>>
>>>
>>>
>>>Thus far we've kept all this stuff out of core.  I believe we should
>>>keep it that way.  This could easily be left in bprm_set().
>>
>>True.  But as long as linux_binprm has fields for this stuff, intuitively 
>>it should always be filled in (i.e. not just in commoncap).  That way we 
>>can say that commoncap doesn't get special treatment :)
>>
>>Also, this seems like the right place to check for VFS caps.  This way we can.
> 
> 
> This does change the current notion of layering.  I see your point though, 
> likening it to say reading inode and finding S_ISUID bit.

On the other hand, no one would put reading of a SELinux security label 
here.  But we already have fields in binprm specifically for commoncap.  I 
have no strong preference.


>>The reason I killed the old algorithm is because it's scary (in the sense 
>>of being complicated and subtle for no good reason) and because I don't see 
>>the point of inheritable caps.  I doubt anything uses them currently on a 
>>vanilla kernel because they don't _do_ anything.  So I killed them.
> 
> 
> This does break all those caps aware apps (yeah, tongue-in-cheek ;-)
> that actually have the idea to widen the effective set, yet limit the
> inheriable set.  Seriously, I don't know how much this matters.

Yah, they're broken anyway right now if that's what they're doing.

The reason I didn't go for something like your approach (other than not 
thinking of it) was that, as long as we're changing the semantics, we might 
as well make them as clean as possible.  I also didn't mind ripping out 
lots of old code :).  If the inheritable mask stays, then programs need to 
be audited for what happens if they are run with different inheritable 
masks.  I'd rather just eliminate that complication and the corresponding 
blob of commoncap code.  Obviously my patch fails a lot of your tests as a 
result.

So do we arm-wrestle over whose implementation wins? :)  I'd say mine wins 
on readability (not your fault -- the old code was pretty bad to begin 
with) and some simplicity, but yours has the benefit of being less intrusive.

--Andy
