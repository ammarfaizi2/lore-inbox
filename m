Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVFWR32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVFWR32 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 13:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVFWR17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 13:27:59 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:46793 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262613AbVFWRRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 13:17:18 -0400
Message-ID: <42BAEEA1.2060305@namesys.com>
Date: Thu, 23 Jun 2005 10:17:21 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Saveliev <vs@namesys.com>
CC: Pekka Enberg <penberg@gmail.com>, Alexander Zarochentcev <zam@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>	 <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com>	 <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com>	 <84144f0205062223226d560e41@mail.gmail.com>  <42BA67C9.7060604@namesys.com> <1119543302.4115.141.camel@tribesman.namesys.com>
In-Reply-To: <1119543302.4115.141.camel@tribesman.namesys.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev wrote:

>  
>
>>>>+/*
>>>>+ * Initialization stages for reiser4.
>>>>+ *
>>>>+ * These enumerate various things that have to be done during reiser4
>>>>+ * startup. Initialization code (init_reiser4()) keeps track of what stage was
>>>>+ * reached, so that proper undo can be done if error occurs during
>>>>+ * initialization.
>>>>+ */
>>>>+typedef enum {
>>>>+	INIT_NONE,               /* nothing is initialized yet */
>>>>+	INIT_INODECACHE,         /* inode cache created */
>>>>+	INIT_CONTEXT_MGR,        /* list of active contexts created */
>>>>+	INIT_ZNODES,             /* znode slab created */
>>>>+	INIT_PLUGINS,            /* plugins initialized */
>>>>+	INIT_PLUGIN_SET,         /* psets initialized */
>>>>+	INIT_TXN,                /* transaction manager initialized */
>>>>+	INIT_FAKES,              /* fake inode initialized */
>>>>+	INIT_JNODES,             /* jnode slab initialized */
>>>>+	INIT_EFLUSH,             /* emergency flush initialized */
>>>>+	INIT_FQS,                /* flush queues initialized */
>>>>+	INIT_DENTRY_FSDATA,      /* dentry_fsdata slab initialized */
>>>>+	INIT_FILE_FSDATA,        /* file_fsdata slab initialized */
>>>>+	INIT_D_CURSOR,           /* d_cursor suport initialized */
>>>>+	INIT_FS_REGISTERED,      /* reiser4 file system type registered */
>>>>+} reiser4_init_stage;
>>>>   
>>>>
>>>>        
>>>>
>>>Please use regular gotos instead. This is a silly hack especially since you
>>>don't have release function for all of the stages.
>>> 
>>>
>>>      
>>>
>>I'll let vs comment.
>>
>>    
>>
>
>IMHO, it is convinient. But lets change it as requested.
>  
>
No, if you like it, say so and it stays.

>>>>+ *
>>>>+ *     kmalloc/kfree leak detection: reiser4_kmalloc(), reiser4_kfree(),
>>>>+ *     reiser4_kfree_in_sb().
>>>>   
>>>>
>>>>        
>>>>
>>>Please don't do this! We've had enough trouble trying to get the
>>>current subsystem specific allocators out, so do not introduce a new one. If
>>>you need memory leak detection, make it generic and submit that. Reiser4, like
>>>all other subsystems, should use kmalloc() and friends directly.
>>> 
>>>
>>>      
>>>
>>I will let vs comment.
>>
>>    
>>
>I agree with Pekka.
>  
>
Ok, can you make it generic easily?

>  
>
>>> 
>>>
>>>      
>>>
>>>>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
>>>>+++ linux-2.6.11-vs/fs/reiser4/debug.h	2005-06-03 17:49:38.297184283 +0400
>>>>+
>>>>+/*
>>>>+ * Error code tracing facility. (Idea is borrowed from XFS code.)
>>>>   
>>>>
>>>>        
>>>>
>>>Could this be turned into a generic facility?
>>> 
>>>      
>>>
>
>I do not think that it will ever become accepted.
>To get use of that task_t would have to be extended with fields to store
>error code, file name and line in it, and several return addresses.
>Moreover lines like 
>return -ENOENT;
>would have to be replaced with:
>return RETERR(-ENOENT);
>
>This is debugging feature, we should probably move it to our internal
>debugging patch.
>
>  
>
>>> 
>>>
>>>      
>>>
>>>>+#define reiser4_internal
>>>>   
>>>>
>>>>        
>>>>
>>>Please drop the above useless #define.
>>>
>>>      
>>>
>
>ok
>
>  
>
>>>>--- /dev/null	2003-09-23 21:59:22.000000000 +0400
>>>>+++ linux-2.6.11-vs/fs/reiser4/init_super.c	2005-06-03 17:51:27.959201950 +0400
>>>>+
>>>>+#define _INIT_PARAM_LIST (struct super_block * s, reiser4_context * ctx, void * data, int silent)
>>>>+#define _DONE_PARAM_LIST (struct super_block * s)
>>>>+
>>>>+#define _INIT_(subsys) static int _init_##subsys _INIT_PARAM_LIST
>>>>+#define _DONE_(subsys) static void _done_##subsys _DONE_PARAM_LIST
>>>>   
>>>>
>>>>        
>>>>
>>>Please remove this macro obfuscation.
>>> 
>>>
>>>      
>>>
>>vs, I think he is right, do you?
>>
>>    
>>
>>> 
>>>
>>>      
>>>
>>>>+
>>>>+_DONE_EMPTY(exit_context)
>>>>+
>>>>+struct reiser4_subsys {
>>>>+	int  (*init) _INIT_PARAM_LIST;
>>>>+	void (*done) _DONE_PARAM_LIST;
>>>>+};
>>>>+
>>>>+#define _SUBSYS(subsys) {.init = &_init_##subsys, .done = &_done_##subsys}
>>>>+static struct reiser4_subsys subsys_array[] = {
>>>>+	_SUBSYS(mount_flags_check),
>>>>+	_SUBSYS(sinfo),
>>>>+	_SUBSYS(context),
>>>>+	_SUBSYS(parse_options),
>>>>+	_SUBSYS(object_ops),
>>>>+	_SUBSYS(read_super),
>>>>+	_SUBSYS(tree0),
>>>>+	_SUBSYS(txnmgr),
>>>>+	_SUBSYS(ktxnmgrd_context),
>>>>+	_SUBSYS(ktxnmgrd),
>>>>+	_SUBSYS(entd),
>>>>+	_SUBSYS(formatted_fake),
>>>>+	_SUBSYS(disk_format),
>>>>+	_SUBSYS(sb_counters),
>>>>+	_SUBSYS(d_cursor),
>>>>+	_SUBSYS(fs_root),
>>>>+	_SUBSYS(safelink),
>>>>+	_SUBSYS(exit_context)
>>>>+};
>>>>   
>>>>
>>>>        
>>>>
>>>The above is overkill and silly. parse_options and read_super, for
>>>example, are _not_ a subsystem inits but regular fs ops. Please consider
>>>dropping this altogether but at least trim it down to something sane.
>>>
>>>      
>>>
>
>Pekka, would you prefer something like:
>
>reiser4_fill_super()
>{
>    if (init_a() == 0) {
>	if (init_b() == 0) {
>	    if (init_c() == 0) {
>		if (init_last() == 0)
>		    return 0;
>		else {
>		    done_c();
>		    done_b();
>		    done_a();
>		}
>	    } else {
>		done_b();
>		done_a();
>	    }
>	} else {
>	    done_a();
>	}
>    }
>}
>  
>
I think the above is easier to read than the below.  Macros can obscure
sometimes, and one of our weaknesses is a tendency to use macros in such
a way that it frustrates meta-. use in emacs.   Nikita did however
mention that there was something that could understand macros when
constructing tags files, but I forgot what that was.

>With these macros we have reiser4_fill_super to look like the below, and
>it remains unchanged when something new is added for initilizing on
>filesystem mounting.
>
>reiser4_fill_super()
>{
>	for (i = 0; i < REISER4_NR_SUBSYS; i++) {
>		ret = subsys_array[i].init(s, &ctx, data, silent);
>		if (ret) {
>			done_super(s, i - 1);
>			return ret;
>		}
>	}
>}
>
>
>
>
>  
>

