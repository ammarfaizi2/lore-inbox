Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbWCGDXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWCGDXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWCGDXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:23:47 -0500
Received: from ms-smtp-01-smtplb.tampabay.rr.com ([65.32.5.131]:44164 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1752483AbWCGDXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:23:46 -0500
Message-ID: <440CFCA6.5090100@cfl.rr.com>
Date: Mon, 06 Mar 2006 22:23:18 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udf: fix uid/gid options and add uid/gid=ignore and forget
 options
References: <4409EB37.5050308@cfl.rr.com> <84144f020603051122k33872fa7p1e7baebcc2b67cda@mail.gmail.com> <440B8C16.4050008@cfl.rr.com> <Pine.LNX.4.58.0603060924450.11070@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0603060924450.11070@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> Hi Phillip,
> 
> On Sun, 5 Mar 2006, Phillip Susi wrote:
>> My bad, I meant to remove those ifs, not just prepend them with an else.  Try
>> this one:
>>
>> c8393f6e4fe6159fd916f3c68091e76bbfdc5fd8
>> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
>> index 395e582..49aeac3 100644
>> --- a/fs/udf/inode.c
>> +++ b/fs/udf/inode.c
>> @@ -1045,10 +1045,12 @@ static void udf_fill_inode(struct inode        }
>>
>>        inode->i_uid = le32_to_cpu(fe->uid);
>> -      if ( inode->i_uid == -1 ) inode->i_uid = UDF_SB(inode->i_sb)->s_uid;
>> +      if ( inode->i_uid == -1 || UDF_QUERY_FLAG(inode->i_sb,
>> UDF_FLAG_UID_IGNORE) )
>> +        inode->i_uid = UDF_SB(inode->i_sb)->s_uid;
> 
> Formatting.
> 

What exactly do you mean by formatting?

>>        inode->i_gid = le32_to_cpu(fe->gid);
>> -      if ( inode->i_gid == -1 ) inode->i_gid = UDF_SB(inode->i_sb)->s_gid;
>> +      if ( inode->i_gid == -1 || UDF_QUERY_FLAG(inode->i_sb,
>> UDF_FLAG_GID_IGNORE) )
>> +        inode->i_gid = UDF_SB(inode->i_sb)->s_gid;
> 
> Same here.
> 
>>        inode->i_nlink = le16_to_cpu(fe->fileLinkCount);
>>        if (!inode->i_nlink)
>> @@ -1335,11 +1337,13 @@ udf_update_inode(struct inode *inode, in
>>        return err;
>>        }
>>
>> -      if (inode->i_uid != UDF_SB(inode->i_sb)->s_uid)
>> -      fe->uid = cpu_to_le32(inode->i_uid);
>> -
>> -      if (inode->i_gid != UDF_SB(inode->i_sb)->s_gid)
>> -      fe->gid = cpu_to_le32(inode->i_gid);
>> +      if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_UID_FORGET))
>> +        fe->uid = cpu_to_le32(-1);
>> +      else fe->uid = cpu_to_le32(inode->i_uid);
> 
> This is better, but if id was -1 on disk, we're overriding it unless the 
> forget mount option was specified. Do we want that? I think my patch is a 
> better fix (if it works anyway) and yours should be on top of that. Did 
> you have the chance to test it?
> 

Yes, if you chown a file that is owned by -1 on disk, you do want it to 
be saved back with the new id, unless you set the forget option.

> Also, formatting is, wrong, just make it
> 
> 	if (forget)
> 		fe->uid = ...;
> 	else
> 		fe->uid = ...;
> 

You mean use hard tabstops instead of two spaces to indent?  Is there a 
way to set emacs to do that?  It automatically uses the two spaces.

>> +      if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_GID_FORGET))
>> +        fe->gid = cpu_to_le32(-1);
>> +      else fe->gid = cpu_to_le32(inode->i_gid);
>>
>>        udfperms =      ((inode->i_mode & S_IRWXO)     ) |
>>        ((inode->i_mode & S_IRWXG) << 2) |
> 
> Same here.
> 
> Please document the new mount options in Documentation/filesystems/udf.txt.
> 

Working on it.


