Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVCRQP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVCRQP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVCRQOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:14:15 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:14732 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261680AbVCRQNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:13:31 -0500
Message-ID: <423AFE25.1060403@acm.org>
Date: Fri, 18 Mar 2005 10:13:25 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: Re: [PATCH] Add a non-blocking interface to the I2C code, part 1
References: <42261AFB.40001@acm.org> <20050317070940.GA15508@kroah.com>
In-Reply-To: <20050317070940.GA15508@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Wed, Mar 02, 2005 at 01:58:51PM -0600, Corey Minyard wrote:
>  
>
>>This patch reorganizes the I2C SMBus formatting code to make it more
>>suitable for the upcoming non-blocking changes.
>>    
>>
>
>You are changing too much stuff here to claim it's just a
>reorganization:
>	- variable name changes for no reason
>  
>
Well, yes.  Both "adap" and "adapter" are used to refer to the same 
thing in the file; "adap" seemed to be the most common usage so I chose 
that for the new functions I added. In one place I changed adapter to 
adap.  I also changed "res" to "result".  I can fix those.  Or I can 
submit a patch first that renames the adap and adapter to make the usage 
consistent (I would prefer adapter).

>	- coding style changes (improper ones at that)
>  
>
I don't see that.  The ugliest thing about this is the functions that 
take the massive numbers of parameters, but that goes away in the next 
patch which puts all the data into a single data structure and passes it 
around.  The code here was also very inconsistent about use of spaces, 
like x(a,b,c) vs x(a, b, c), "struct a *b" vs "struct a * b", "a=b" vs 
"a = b".  It's hard to know what was right.  The changes I made in these 
respects was to try to make it use the usage most common in the file.

If you like, I can do a pass and make everything consistent in the file 
as part of the previous patch I talked about.

>	- logic changes.
>  
>
I tried very hard not to make logic changes.  Now I see there were two 
places where the function checked client->adapter->algo->master_xfer 
then called i2c_transfer(), which did the same check and returned the 
same error if it was NULL.  I removed the redundant check.  That belongs 
in a separate patch.  I couldn't find any others.

>What exactly are you doing with this patch, and why?
>  
>
The i2c main functions do the following:

  Format the data for transmission
  Send the data to the next layer down for handling
  Clean up the results

The original code did all this in single big functions.  This patch 
breaks the formatting and cleanup operations into separate functions.  
Beyond one big function being ugly, the non-blocking code needs this 
because it needs to perform these separately.  When you start the 
operation, the non-blocking code needs to do the format then return.  
Later on, when the operation is complete, the thread of execution 
handling the completion will do the cleanup.

-Corey
