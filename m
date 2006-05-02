Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWEBOyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWEBOyu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWEBOyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:54:50 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:16911 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S964854AbWEBOyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:54:50 -0400
Message-ID: <445772B1.8010904@argo.co.il>
Date: Tue, 02 May 2006 17:54:41 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Martin Mares <mj@ucw.cz>, Willy Tarreau <willy@w.ods.org>,
       David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com> <20060502051238.GB11191@w.ods.org> <44573525.7040507@argo.co.il> <mj+md-20060502.111446.9373.atrey@ucw.cz> <445741F5.6060204@argo.co.il> <mj+md-20060502.124648.6316.atrey@ucw.cz> <44576435.80603@argo.co.il> <20060502141305.GV27946@ftp.linux.org.uk>
In-Reply-To: <20060502141305.GV27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 May 2006 14:54:47.0757 (UTC) FILETIME=[5B4A97D0:01C66DF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Tue, May 02, 2006 at 04:52:53PM +0300, Avi Kivity wrote:
>   
>> static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
>> 			   size_t count, loff_t max)
>> {
>> 	loff_t pos;
>> 	ssize_t retval;
>>
>> 	/*
>> 	 * Get input file, and verify that it is ok..
>> 	 */
>> 	light_file_ptr in_file(in_fd);
>>     
>
> *snerk*
> Good luck defining copying and conversion to file * for that puppy.  
>
>   

class light_file_ptr {
public:
    explicit light_file_ptr(int fd)
    {
        _file = fget_light(fd, &_fput_needed);
    }
    ~light_file_ptr()
    {
        fput_light(_file, _fput_needed);
    }
    bool valid() const
    {
        return _file != 0;
    }
    struct file *operator->() // allowed for libs :)
    {
        return _file;
    }
private:
    struct file *_file;
    int _fput_needed;
};


>> 	struct inode *in_inode = in_file->dentry()->inode();
>>     
>
> Lovely.  Let's expose all fields as methods?
>
>   

If you like. I won't insist.

>> 	if (!in_inode)
>> 		return -EINVAL;
>>     
>
> BTW, that can't happen.  Applies to the original as well.
>
>   

I believe this bug is more visible when there is less code in the function.

>> 	// I'm assuming here that the default sendfile() returns -EINVAL
>> 	if (!ppos)
>> 		ppos = &in_file->f_pos;
>> 	else
>> 		if (!(in_file->mode() & FMODE_PREAD))
>> 			return -ESPIPE;
>>     
>
> As opposed to ->readable() for checking FMODE_READ?
>
>   

Forgot, sorry. I'll redo the patch.

>> 	light_file_ptr out_file(out_fd);
>> 	if (!out_file)
>> 		return -EBADF;
>>     
>
> ?
>   

Sorry, !out_file.valid().

>> 	if (!max)
>> 		max = min(in_inode->i_sb->s_maxbytes, 
>> 		out_inode->i_sb->s_maxbytes);
>>     
>
> While we are at it, that's the only place where in_inode and out_inode
> are used.  Also... how does one remember which of ->dentry, ->inode
> and ->i_sb are methods and which are public fields?
>   

I usually make all publics either methods (a class) or fields (a struct).


>> // now, with exceptions
>> static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
>> 			   size_t count, loff_t max)
>> {
>> 	loff_t pos;
>>
>> 	/*
>> 	 * Get input file, and verify that it is ok..
>> 	 */
>> 	light_file_ptr in_file(in_fd);
>> 	in_file->verify_readable();
>>     
>
> That assumes that error value returned in that case is the same everywhere.
> It isn't.
>   

Okay, in_file->verify_readable(EBADF); Yuck.

Thanks for the review.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

