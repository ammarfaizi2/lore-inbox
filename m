Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbTIHPgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTIHPgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:36:23 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:62674 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S262681AbTIHPez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:34:55 -0400
From: Ingo Oeser <ingo@oeser-vu.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] authentication / encryption key retention
Date: Mon, 8 Sep 2003 17:30:55 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <6999.1062771569@redhat.com>
In-Reply-To: <6999.1062771569@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309081730.55717.ingo@oeser-vu.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

some suggestions to improve your patch. First: It is very elegant.

> @@ -98,6 +103,11 @@
>  		atomic_set(&new->processes, 0);
>  		atomic_set(&new->files, 0);
>
> +		if (alloc_uid_keyring(new) < 0) {
> +			kmem_cache_free(uid_cachep, up);

this should be 'new' instead of 'up'

> +			return NULL;
> +		}
> +
>  		/*
>  		 * Before adding this, check whether we raced
>  		 * on adding the same user already..
> @@ -130,6 +140,7 @@
>  	atomic_dec(&old_user->processes);
>  	current->user = new_user;
>  	free_uid(old_user);
> +	suid_keys(current);
>  }

> +config KEYS
> +	bool "Enable access key retention support"
> +	help
> +	  This option provides support for retaining authentication tokens and
> +	  access keys in the kernel.
> +
> +	  It also includes provision of methods by which such keys might be
> +	  associated with a process so that network filesystems, encryption
> +	  support and the like can find them.

Maybe the keyword "keyring" should be put here somehow, since many 
security people know this concept by exactly this name.

> linux-2.6.0-test4/security/keys/key.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.0-test4-keys/security/keys/key.c	2003-08-29 11:07:39.000000000 +0100 
> +	spin_lock(&key_serial_lock);
> +
> +	/* propose a serial number and try to insert it into the tree */
> +	key->serial = key_serial_next;
> +	if (key->serial < 2)
> +		key->serial = 2;
> +	key_serial_next = key->serial + 1;
> +
> +	parent = NULL;
> +	p = &key_serial_tree.rb_node;
> +
> +	while (*p) {
> +		parent = *p;
> +		xkey = rb_entry(parent, struct key, serial_node);
> +
> +		if (key->serial < xkey->serial)
> +			p = &(*p)->rb_left;
> +		else if (key->serial > xkey->serial)
> +			p = &(*p)->rb_right;
> +		else
> +			goto serial_exists;
> +	}
> +	goto insert_here;
> +
> +	/* we found a key with the proposed serial number - walk the tree from
> +	 * that point looking for the next unused serial number */
> + serial_exists:
> +	for (;;) {
> +		key->serial = key_serial_next;
> +		if (key->serial < 2)
> +			key->serial = 2;
> +		key_serial_next = key->serial + 1;
> +
> +		if (!parent->rb_parent)
> +			p = &key_serial_tree.rb_node;
> +		else if (parent->rb_parent->rb_left == parent)
> +			p = &parent->rb_parent->rb_left;
> +		else
> +			p = &parent->rb_parent->rb_right;
> +
> +		parent = rb_next(parent);
> +		if (!parent)
> +			break;
> +
> +		xkey = rb_entry(parent, struct key, serial_node);
> +		if (key->serial < xkey->serial)
> +			goto insert_here;
> +	}
> +
> + insert_here:
> +	rb_link_node(&key->serial_node, parent, p);
> +	rb_insert_color(&key->serial_node, &key_serial_tree);
> +	spin_unlock(&key_serial_lock);
> +
> +	*_key = key;
> +	return 0;
> +} /* end key_alloc() */

Maybe this allocator should be separated. It will be useful outside this
function.

> +void key_retire(struct key *key)
> +{


> +
> +	/* duplicate the list of subscribed keys */
> +	if (source->payload.subscriptions) {
> +		/* prevent the source keyring from being altered */
> +		down_read(&source->sem);
> +
[...]
> +
> +		up_read(&source->sem);
> +	}

You should take the semaphore always to prevent the tiny race, where you
allocate the first subscription, while you check this.

> +int keyring_search(struct key *keyring,
> +		   const struct key_type *type,
> +		   const char *description,
> +		   struct key **_key)
> +{
> +	struct {
> +		struct key *keyring;
> +		struct keyring_list *keylist;
> +		int kix;
> +	} stack[KEYRING_SEARCH_MAX_DEPTH];
> +
> +	struct keyring_list *keylist;
> +	struct key *key;
> +	int sp, psp, kix;
> +
> +	key_validate(keyring);
> +
> +	*_key = NULL;
> +
> +	if (keyring->type != &key_type_keyring)
> +		return -EINVAL;
> +
> +	sp = 0;
> +
> + descend:
> +	read_lock(&keyring->lock);
> +	if (keyring->flags & KEY_FLAG_RETIRED)
> +		goto retired;
> +
> +	keylist = keyring->payload.subscriptions;
> +	kix = 0;
> +
> + ascend:
> +	while (kix < keylist->nkeys) {
> +		key = keylist->keys[kix];
> +
> +		if (key->type == type && key->type->match(key, description)) {
> +			if (key->flags & KEY_FLAG_RETIRED)
> +				goto next;
> +			atomic_inc(&key->usage);
> +			goto found;
> +		}
> +
> +		if (key->type == &key_type_keyring) {
> +			if (sp >= KEYRING_SEARCH_MAX_DEPTH)
> +				goto next;
> +
> +			/* evade loops in the keyring tree */
> +			for (psp = 0; psp < sp; psp++)
> +				if (stack[psp].keyring == keyring)
> +					goto next;
> +
> +			stack[sp].keyring = keyring;
> +			stack[sp].keylist = keylist;
> +			stack[sp].kix = kix;
> +			sp++;
> +			goto descend;
> +		}
> +
> +	next:
> +		kix++;
> +	}
> +
> + retired:
> +	read_unlock(&keyring->lock);
> +
> +	if (sp > 0) {
> +		sp--;
> +		keyring = stack[sp].keyring;
> +		keylist = stack[sp].keylist;
> +		kix = stack[sp].kix + 1;
> +		goto ascend;
> +	}

Why do you do the iteration without taking the spinlock here?
That whole function looks a little hackish and is difficult to follow. I
would at least like to see 
for (; kix < keyring->payload.subscriptions->nkeys; kix++) {
	key = keyring->payload.subscriptions->keys[kix];
}

Now the goto next becomes continue.

You also never need to store keylist on the stack, because of the identity
stack[sp].keyring->payload.subscriptions == stack[sp].keylist

This should reduce stack usage or allow deeper nesting.

Loop detection should better be done on insert, not on search.
With the above code you allow loops, but ignore them, right?

> +int keyring_set_name(struct key *keyring, const char *fmt, ...)
> +{
> +	struct keyring_name *kname;
> +	va_list va;
> +	size_t len;
> +	char buf[32];
> +
> +	key_validate(keyring);
> +
> +	if (keyring->type != &key_type_keyring)
> +		return -EINVAL;
> +
> +	va_start(va, fmt);
> +	vsnprintf(buf, 32, fmt, va);

you should check the return value of vsnprintf here end fail for 
ret >= sizeof(buf)

> +	va_end(va);
> +	len = strlen(buf);

Then this becomes unnecessary.

 
> +/*************************************************************************
>****/ +/*
> + * describe the keyring
> + */
> +static void keyring_describe(const struct key *keyring, struct seq_file
> *m) +{
> +	struct keyring_name *kname;
> +	struct keyring_list *klist;
> +
> +	kname = keyring->description.ringname;
> +	if (kname) {
> +		seq_printf(m, "%s", kname->name);

What about seq_puts(kname->name) here?


> +static int install_session_keyring(struct task_struct *tsk)
> +{
> +	struct key *keyring;
> +	int ret;
> +
> +	ret = keyring_alloc(NULL, &keyring);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = keyring_set_name(keyring, "_ses.%u", keyring->serial);
> +	if (ret < 0)
> +		return ret;
> +
> +	key_put(xchg(&tsk->session_keyring, keyring));
> +
> +	return 0;
> +} /* end install_session_keyring() */

Why is this one implemented differently from the others above?

> +long clear_process_keyring(int specifier)
> +{
> +
> +	case PR_SPEC_GROUP_KEYRING:
> +	default:
> +		return -EINVAL;
> +	}

Not implemented, yet? ;-)

> +/*************************************************************************
>****/ +/*
> + * install a new session keyring, discarding the old one
> + * - implements prctl(PR_NEW_SESSION_KEYRING)
> + */
> +long new_session_keyring(void)
> +{
> +	int ret;
> +
> +	ret = install_session_keyring(current);
> +	if (ret < 0)
> +		return ret;
> +
> +	return current->session_keyring ? current->session_keyring->serial : 0;
> +
> +} /* end new_session_keyring() */

You evaluate current three times here. Evaluating it is expensive. You
might consider using a variable holding current instead.

> +long add_user_key(int specifier,
> +		  char __user *_type,
> +		  char __user *_description,
> +		  void __user *_payload)
> +{
[...]
> +	ret = get_user(plen, (uint16_t *) _payload);

Why this cast?

> +int copy_keys(unsigned long clone_flags, struct task_struct *tsk)
> +{
> +	int ret = 0;
> +
> +	key_validate(tsk->session_keyring);
> +	key_validate(tsk->process_keyring);
> +	key_validate(tsk->thread_keyring);
> +
> +	if (tsk->session_keyring)
> +		atomic_inc(&tsk->session_keyring->usage);
> +
> +	if (tsk->process_keyring) {
> +		if (clone_flags & CLONE_THREAD) {
> +			atomic_inc(&tsk->process_keyring->usage);
> +		}
> +		else {
> +			tsk->process_keyring = NULL;
> +			ret = install_process_keyring(tsk);
> +		}
> +	}
> +
> +	tsk->thread_keyring = NULL;
> +
> +	return ret;
> +} /* end copy_keys() */

What about the per thread keyring?
Is there an atomic_inc(tsk->thread_keyring) missing?

So all in all, it looks like a very nice and clean patch.

I'm looking forward to have this included.

Regards

Ingo Oeser


