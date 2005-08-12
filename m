Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVHLIaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVHLIaI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 04:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVHLIaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 04:30:08 -0400
Received: from koto.vergenet.net ([210.128.90.7]:38538 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750724AbVHLIaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 04:30:06 -0400
Date: Fri, 12 Aug 2005 17:29:36 +0900
From: Horms <horms@debian.org>
To: Alexander Pytlev <apytlev@tut.by>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: kernel 2.4.27-10: isofs driver ignore some parameters with mount
Message-ID: <20050812082936.GB3302@verge.net.au>
Mail-Followup-To: Alexander Pytlev <apytlev@tut.by>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
References: <1853917171.20050812104417@tut.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1853917171.20050812104417@tut.by>
X-Cluestick: seven
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 10:44:17AM +0300, Alexander Pytlev wrote:
> Hello Debian,
> 
> Kernel 2.4.27-10
> With mount isofs filesystem, any mount parameters after
> iocharset=,map=,session= are ignored.
> 
> Sample:
> 
> mount -t isofs -o uid=100,iocharset=koi8-r,gid=100 /dev/cdrom /media/cdrom
> 
> gid=100 - was ignored
> 
> I look in source and find that problem. I make two patch, simply and full
> (what addeded some functionality - ignore wrong mount parameters)

Thanks,

I will try and get the simple version of this patch into the next
Sarge update.

I have also CCed Marcelo and the LKML for their consideration,
as this problem still seems to be present in the lastest 2.4 tree.

-- 
Horms

simply patch:
===================================================================================
--- kernel-source-2.4.27/fs/isofs/inode.c       2005-05-19 13:29:39.000000000 +0300
+++ kernel-source/fs/isofs/inode.c      2005-08-11 11:55:12.000000000 +0300
@@ -340,13 +340,13 @@
                        else if (!strcmp(value,"acorn")) popt->map = 'a';
                        else return 0;
                }
-               if (!strcmp(this_char,"session") && value) {
+               else if (!strcmp(this_char,"session") && value) {
                        char * vpnt = value;
                        unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
                        if(ivalue < 0 || ivalue >99) return 0;
                        popt->session=ivalue+1;
                }
-               if (!strcmp(this_char,"sbsector") && value) {
+               else if (!strcmp(this_char,"sbsector") && value) {
                        char * vpnt = value;
                        unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
                        if(ivalue < 0 || ivalue >660*512) return 0;
===================================================================================

full patch:
===================================================================================
--- kernel-source-2.4.27/fs/isofs/inode.c       2005-05-19 13:29:39.000000000 +0300
+++ kernel-source/fs/isofs/inode.c      2005-08-11 11:50:56.000000000 +0300
@@ -327,10 +327,11 @@
                        popt->iocharset = value;
                        while (*value && *value != ',')
                                value++;
-                       if (value == popt->iocharset)
-                               return 0;
                        *value = 0;
-               } else
+                       if (value == popt->iocharset){
+                           printk("Invalid or missed parameter:%s=%s,\n",this_char,value);
+                       }
+               }
 #endif
                if (!strcmp(this_char,"map") && value) {
                        if (value[0] && !value[1] && strchr("ano",*value))
@@ -338,28 +339,30 @@
                        else if (!strcmp(value,"off")) popt->map = 'o';
                        else if (!strcmp(value,"normal")) popt->map = 'n';
                        else if (!strcmp(value,"acorn")) popt->map = 'a';
-                       else return 0;
+                       else printk("Invalid or missed parameter:%s=%s,\n",this_char,value);
                }
                if (!strcmp(this_char,"session") && value) {
                        char * vpnt = value;
                        unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
-                       if(ivalue < 0 || ivalue >99) return 0;
-                       popt->session=ivalue+1;
+                       if(ivalue < 0 || ivalue >99)
+                           printk("Invalid or missed parameter:%s=%s,\n",this_char,value);
+                       else popt->session=ivalue+1;
                }
                if (!strcmp(this_char,"sbsector") && value) {
                        char * vpnt = value;
                        unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
-                       if(ivalue < 0 || ivalue >660*512) return 0;
-                       popt->sbsector=ivalue;
+                       if(ivalue < 0 || ivalue >660*512)
+                           printk("Invalid or missed parameter:%s=%s,\n",this_char,value);
+                       else popt->sbsector=ivalue;
                }
-               else if (!strcmp(this_char,"check") && value) {
+               if (!strcmp(this_char,"check") && value) {
                        if (value[0] && !value[1] && strchr("rs",*value))
                                popt->check = *value;
                        else if (!strcmp(value,"relaxed")) popt->check = 'r';
                        else if (!strcmp(value,"strict")) popt->check = 's';
-                       else return 0;
+                       else printk("Invalid or missed parameter:%s=%s,\n",this_char,value);
                }
-               else if (!strcmp(this_char,"conv") && value) {
+               if (!strcmp(this_char,"conv") && value) {
                        /* no conversion is done anymore;
                           we still accept the same mount options,
                           but ignore them */
@@ -368,22 +371,24 @@
                        else if (!strcmp(value,"text")) ;
                        else if (!strcmp(value,"mtext")) ;
                        else if (!strcmp(value,"auto")) ;
-                       else return 0;
+                       else printk("Invalid or missed parameter:%s=%s,\n",this_char,value);
                }
-               else if (value &&
+               if (value &&
                         (!strcmp(this_char,"block") ||
                          !strcmp(this_char,"mode") ||
                          !strcmp(this_char,"uid") ||
                          !strcmp(this_char,"gid"))) {
                  char * vpnt = value;
                  unsigned int ivalue = simple_strtoul(vpnt, &vpnt, 0);
-                 if (*vpnt) return 0;
+                 if (*vpnt) printk("Invalid or missed parameter:%s=%s,\n",this_char,value);
+                 else
                  switch(*this_char) {
                  case 'b':
                    if (   ivalue != 512
                        && ivalue != 1024
-                       && ivalue != 2048) return 0;
-                   popt->blocksize = ivalue;
+                       && ivalue != 2048)
+                       printk("Invalid or missed parameter:%s=%s,\n",this_char,value);
+                   else popt->blocksize = ivalue;
                    break;
                  case 'u':
                    popt->uid = ivalue;
@@ -396,7 +401,6 @@
                    break;
                  }
                }
-               else return 1;
        }
        return 1;
 }
===================================================================================

