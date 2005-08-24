Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVHXHnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVHXHnB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVHXHnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:43:00 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:56753 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750736AbVHXHnA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:43:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LcRbQYN6wZmKr5/cUcaDEjlTLAuCQ6ARRxoqOndbizdFrVIxW10R8FjAzhLMy4Hok5begdLaBWFRGpLPHw6ZiAey6xpZZwpdDtOZ6Lv3NUjsC5sP2/9wmQVxpNf/6mivHY4jL9/1Z0CLOHLSkuH3cCMxcCZK3mLt6C5xC/2tLao=
Message-ID: <615cd8d1050824004230feb6bc@mail.gmail.com>
Date: Wed, 24 Aug 2005 15:42:51 +0800
From: =?BIG5?B?vFi50w==?= <brianhsu.hsu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How can I get link target from a full path name.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I would like to know how can I figure out where is a symbolic link
file pointing to.

for example:

/a.txt is a symbolic link to /root/a.txt , how can I get /root/a.txt
when I passing /a.txt
to my function?

I tought path_loookup and d_path is useful, and I wrote a function,
but the path_lookup
function always return -2 , which seems means that there is no such
file, but I am sure
the file exists.

Here is my code, any sugguestion? and thanks for your help.


int catfs_get_path_target ( const char * filename , char ** target_path , 
                                        char ** target_mnt_point )
{
    int error = 0;
    
    char buffer[255];
    char buffer2[255];

    char * fullpath = NULL;
    char * mnt_point = NULL;
    struct nameidata nd;
    struct file * filp = NULL;
    
    if ( filename == NULL ) {
        error = -1;
        goto out;
    }
    
    error = path_lookup ( filename , 0 , &nd );
    
    if ( error ) {
        printk ( "Error:%d\n" , error );
        error = -1;
        goto out;
    }
    
    memset ( buffer , 0 , 255 );
    memset ( buffer2 , 0 , 255 );
    
    fullpath  = d_path(filp->f_dentry,filp->f_vfsmnt,buffer,255) + 1;
    mnt_point =
d_path(filp->f_vfsmnt->mnt_mountpoint,filp->f_vfsmnt->mnt_parent,buffer2,255);
    
    if ( mnt_point[strlen(mnt_point)-1] != '/' ) {
        strcat ( mnt_point , "/" );
    }

    *target_path = kmalloc ( sizeof(char) * strlen(fullpath) + 1 , GFP_KERNEL );

    if ( *target_path == NULL ) {
        *target_path = NULL;
        error = -1;
        goto out;
    }

    *target_mnt_point = kmalloc ( sizeof(char) * strlen(mnt_point) + 1
, GFP_KERNEL );

    if ( *target_mnt_point == NULL ) {
        *target_path = NULL;
        error = -1;
        goto out;
    }

    strcpy ( *target_path , fullpath );
    strcpy ( *target_mnt_point , mnt_point );

    path_release ( &nd );

out:
    return error;
}
