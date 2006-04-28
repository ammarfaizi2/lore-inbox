Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWD1IRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWD1IRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 04:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWD1IRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 04:17:07 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:65290 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1030323AbWD1IRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 04:17:05 -0400
Message-ID: <4451CF7A.5040902@argo.co.il>
Date: Fri, 28 Apr 2006 11:16:58 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Denis Vlasenko <vda@ilport.com.ua>, Kyle Moffett <mrmacman_g4@mac.com>,
       Roman Kononov <kononov195-far@yahoo.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <4EE8AD21-55B6-4653-AFE9-562AE9958213@mac.com> <44507BB9.7070603@argo.co.il> <200604271655.48757.vda@ilport.com.ua> <4450D4E9.4050606@argo.co.il> <mj+md-20060427.145744.9154.atrey@ucw.cz> <4450E3CB.1090206@argo.co.il> <mj+md-20060427.153429.15386.atrey@ucw.cz>
In-Reply-To: <mj+md-20060427.153429.15386.atrey@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2006 08:17:03.0243 (UTC) FILETIME=[2147BDB0:01C66A9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
>> This is pushing all boundaries, however. That code is horrible.
>>
>>     
>>> It's somewhat ugly inside, but an equally strong generic structure build
>>> with templates will be probably even uglier.
>>>
>>>       
>> Not at all.
>>     
>
> So, show your version :-)
>
> (as fast as this one, of course)
>
> 				Have a nice fortnight
>   
Here you go. In practice one would probably uninline get() and possibly put().

It doesn't do all that your example does (a 15 minute hack), but it is easily expandable. It 
also allows a value to belong to two different hash tables (on two different keys) simultaneously.

#include <cassert>

template <typename Key, class Value, class Traits>
class Hashtable
{
public:
    class Link {
    private:
        Link* next;
        Value& value()
        {
            return *static_cast<Value*>(this);
        }
        friend class Hashtable;
    };
public:
    explicit Hashtable(int size)
        : _size(size)
        , _buckets(new Link[size])
    {
        assert((_size & (_size -  1)) == 0);
    }
    ~Hashtable()
    {
        delete[] _buckets;
    }
    Value* get(const Key& key)
    {
        Link* link = _buckets[Traits::hash(key) & (_size - 1)].next;
        while (link && !Traits::equal(key, link->value()))
            link = link->next;
        if (link)
            return &link->value();
        return 0;
    }
    void put(Value& value)
    {
        // assumes value (or a value with an equal key) is not already in
        Link& head = _buckets[Traits::hash(value) & (_size - 1)];
        static_cast<Link&>(value).next = &head;
        head.next= &value;
    }
private:
    int _size;
    Link* _buckets;
};

// example program

#include <iostream>
#include <string.h>

struct Word;
struct WordHashTraits;
typedef Hashtable<const char*, Word, WordHashTraits> WordHash;

struct Word : WordHash::Link
{
    explicit Word(const char* _word) : word(_word), count(0) {}
    const char* word;
    int count;
};

struct WordHashTraits
{
    static unsigned hash(const char* key)
    {
        // assume this is jenkin's hash.
        unsigned h = 0;
        while (*key) {
            h = (h << 3) | (h >> 29);
            h ^= (unsigned char)*key++;
        }
        return h;
    }
    static unsigned hash(const Word& value)
    {
        return hash(value.word);
    }
    static bool equal(const char* key, const Word& value)
    {
        return strcmp(key, value.word) == 0;
    }
};

int main(int ac, const char** av)
{
    WordHash hashtable(16); // make collisions likely
    for (int i = 1; i < ac; ++i) {
        const char* word = av[i];
        Word* word_in_hash = hashtable.get(word);
        if (!word_in_hash) {
            word_in_hash = new Word(word);
            hashtable.put(*word_in_hash);
        }
        ++word_in_hash->count;
        std::cout << "word: " << word << " count " << word_in_hash->count << "\n";
    }
}









-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

