Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWCZMo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWCZMo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWCZMo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:44:27 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:51636 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751353AbWCZMo0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:44:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cetaiFzKe4OOzZZzEs3jIviuoCPrtCCcvCdepw92qOGzrWYwpeEmwOI6zCLp9GHfcJ5sx43sMp9gvN9p827Mmz/EmI2/b6hJ7VacTyQ2qPjWjsLMT8I8Ryq6Dm63TAb+3Hsk3O5huO6wnU6jEjlSC3041VtLdO+ko+WYGTDWsWg=
Message-ID: <9a8748490603260444w4ecfc5b4u820dd5a99f1f0c3c@mail.gmail.com>
Date: Sun, 26 Mar 2006 14:44:25 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH] fix potential null pointer deref in quota
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060320094601.GA11037@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603182308.05050.jesper.juhl@gmail.com>
	 <20060320094601.GA11037@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/06, Jan Kara <jack@suse.cz> wrote:
>   Hello,
>
> > The coverity checker noticed that we may pass a NULL super_block to
> > do_quotactl() that dereferences it.
> > Dereferencing NULL pointers is bad medicine, better check and fail
> > gracefully.
>   Umm, when do you think we can dereference NULL pointer to a super_block?
> check_quotactl_valid() allows sb==NULL only in the case of Q_SYNC command.
> And that is handled in do_quotactl() correctly even if sb==NULL...
>

Reading the code again it looks like you are right and that this is a
false positive by the coverity checker.

This is what the checker had to say :


346  	asmlinkage long sys_quotactl(unsigned int cmd, const char __user
*special, qid_t id, void __user *addr)
347  	{
348  		uint cmds, type;

Event assign_zero: Variable "sb" assigned value 0.
Also see events:
[var_deref_model][var_deref_model][var_deref_model][var_deref_model][var_deref_model][var_deref_model][var_deref_model][var_deref_model]

349  		struct super_block *sb = NULL;
350  		struct block_device *bdev;
351  		char *tmp;
352  		int ret;
353  	
354  		cmds = cmd >> SUBCMDSHIFT;
355  		type = cmd & SUBCMDMASK;
356  	

At conditional (1): "cmds != 8388609" taking false path
At conditional (2): "special != 0" taking false path

357  		if (cmds != Q_SYNC || special) {
358  			tmp = getname(special);
359  			if (IS_ERR(tmp))
360  				return PTR_ERR(tmp);
361  			bdev = lookup_bdev(tmp);
362  			putname(tmp);
363  			if (IS_ERR(bdev))
364  				return PTR_ERR(bdev);
365  			sb = get_super(bdev);
366  			bdput(bdev);
367  			if (!sb)
368  				return -ENODEV;
369  		}
370  	
371  		ret = check_quotactl_valid(sb, type, cmds, id);

At conditional (3): "ret >= 0" taking true path

372  		if (ret >= 0)

Event var_deref_model: Variable "sb" tracked as NULL was passed to a
function that dereferences it. [model]
Event var_deref_model: Variable "sb" tracked as NULL was passed to a
function that dereferences it. [model]
Event var_deref_model: Variable "sb" tracked as NULL was passed to a
function that dereferences it. [model]
Event var_deref_model: Variable "sb" tracked as NULL was passed to a
function that dereferences it. [model]
Event var_deref_model: Variable "sb" tracked as NULL was passed to a
function that dereferences it. [model]
Event var_deref_model: Variable "sb" tracked as NULL was passed to a
function that dereferences it. [model]
Event var_deref_model: Variable "sb" tracked as NULL was passed to a
function that dereferences it. [model]
Event var_deref_model: Variable "sb" tracked as NULL was passed to a
function that dereferences it. [model]
Also see events:
[assign_zero][var_deref_model][var_deref_model][var_deref_model][var_deref_model][var_deref_model][var_deref_model][var_deref_model]

373  			ret = do_quotactl(sb, type, cmds, id, addr);
374  		if (sb)
375  			drop_super(sb);
376  	
377  		return ret;
378  	}



--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
