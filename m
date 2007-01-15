Return-Path: <linux-kernel-owner+w=401wt.eu-S932206AbXAOKz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbXAOKz2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 05:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbXAOKz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 05:55:27 -0500
Received: from puma.cosy.sbg.ac.at ([141.201.2.23]:60415 "EHLO
	puma.cosy.sbg.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206AbXAOKz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 05:55:27 -0500
Message-ID: <45AB5D98.5000205@cosy.sbg.ac.at>
Date: Mon, 15 Jan 2007 11:55:20 +0100
From: Michael Noisternig <mnoist@cosy.sbg.ac.at>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: configfs: return value for drop_item()/make_item()?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

I've posted this before but without getting any replies. Please, 
somebody either give a (short) reply to this or simply explain why they 
think this is OT or not worth answering...

Here's the issue... the configfs system can prevent a user from 
_creating_ sub-directories in a certain directory (by not supplying 
struct configfs_group_operations->make_item()/make_group()) but it 
cannot prevent him from _removing_ sub-directories because struct 
configfs_group_operations->drop_item() is void.

Similarly, struct configfs_group_operations->make_item() does not permit 
to return an error code, and as such it is impossible to 'check' the 
type of sub-directory a user wants to create (with returning a 
meaningful error code). This had already, unsuccessfully, been brought 
up before on 2006-08-29 by J. Berg (see 
http://marc.theaimsgroup.com/?l=linux-kernel&m=115692319227688&w=2).

Please give some arguments why you think 
configfs_group_operations->drop_item() should remain void.

Thank you very much in advance!

Here's the problem I ran into, explaining further...

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

So what do you think would be an appropriate solution for the problem?

1)
Change configfs' configfs_group_operations->drop_item() to return an 
error code, so the user can be prevented from removing a directory in use.

2)
Keep a reference on each configfs object (e.g. params) in use, so when 
the user removes it from configfs it is still present in memory. This, 
however, requires to rename each according entry in every affected 
param_list to <params removed> or similar... not a very user-friendly 
way to deal with the situation.

3)
Change configfs so a user cannot remove directories with additional 
references on it.

4)
Trace back every object that relies on the params object about to be 
removed, and delete the according params entry from the object's 
params_list automatically... a solution with potentially unexpected side 
effects.

Thank you again for any and every feedback!!!

PS: Please CC me on your replies, I'm not a LKML subscriber.

