Return-Path: <linux-kernel-owner+w=401wt.eu-S1750981AbXAKSQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbXAKSQ4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 13:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbXAKSQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 13:16:56 -0500
Received: from puma.cosy.sbg.ac.at ([141.201.2.23]:45881 "EHLO
	puma.cosy.sbg.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbXAKSQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 13:16:55 -0500
X-Greylist: delayed 1286 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 13:16:55 EST
Message-ID: <45A67A10.7090805@cosy.sbg.ac.at>
Date: Thu, 11 Jan 2007 18:55:28 +0100
From: Michael Noisternig <mnoist@cosy.sbg.ac.at>
Reply-To: mnoist@cosy.sbg.ac.at
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: configfs issues
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've got some issues with using configfs in my module. The problem I ran 
into could be solved if configfs_group_operations->drop_item() would 
allow returning an error code. But I'll try to explain...

(1)
Say the user creates one object, let's say as objects/myobj1/. This 
object is dependent on some (shared) parameters which the user created 
under params/myparams1/. Now while myobj1/ is 'active', I don't want to 
let the user remove myparams1/. I can prevent this by making the user 
create a symlink(2) in the objects/myobj1/ directory to myparams1/, i.e. 
objects/myobj1/params/ -> ../../params/myparams1/, to denote its use. 
Now - if I have read the documentation correctly - the user cannot 
remove myparams1/ without removing the params/ link first. So fine, so good.

(2)
Next the user may create several objects which may be dependent on 
several params objects. Now I can solve this by creating a default group 
for each object, i.e. on myobj1 creation there is objects/myobj1/params/ 
automatically. In that directory the user may create symlink(2)s to 
several params/*/ dirs. Fine again.

(3)
Now what I want is the list of params an object uses to be an ordered 
list. I cannot do this because there is no intrinsic order in a 
filesystem. I can get the order by instead having an attribute called 
param_list which contains the ordered list of all params to use, e.g.
 > cat param_list
  myparams2
  myparams4
  myparams1
However, this way I don't have any way to prevent the user from removing 
params because configfs_group_operations->drop_item() is void and does 
not allow me to return an error.

Question now: Do you think, ->drop_item() should be changed to allow 
returning an error? If not, what do you think would be an appropriate 
solution for the problem? (One solution would be that I trace back every 
object that uses the params to get dropped, and delete the according 
params entry from the object's params_list automatically... another 
would be, that I keep a reference on each params used, so they are 
deleted only from configfs but not from memory on removal, and rename 
the list entries to <removed> or whatever... both ideas I don't like too 
much.)

Thank you for any feedback!!!

PS: Please CC me on your replies, I'm not a LKML subscriber.
